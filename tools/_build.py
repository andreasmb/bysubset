import os, re, shutil
SRC = "_webflow-original"
B = "https://cdn.prod.website-files.com/623f9a8de8e7ac3a9e6b5d8c/"
JQ = "https://d3e54v103j8qbb.cloudfront.net/js/jquery-3.5.1.min.dc5e7f18c8.js?site=623f9a8de8e7ac3a9e6b5d8c"
for d in ("css", "js", "images", "videos"): os.makedirs(d, exist_ok=True)

def clean(n):
    return re.sub(r"^[0-9a-f]{24}_\s*", "", n).replace(" ", "-")

html = open(f"{SRC}/index.html", encoding="utf-8").read()
css = open(f"{SRC}/site.css", encoding="utf-8").read()
mapping = {}  # remote url -> (path from root)
for f in sorted(os.listdir(SRC)):
    if f in ("index.html",): continue
    if f == "site.css":
        dest = "css/site.css"; remote = [B + "css/subsets-beautiful-site.webflow.shared.5416cad54.css"]
    elif f.endswith(".js"):
        dest = "js/" + f
        remote = [JQ] if f.startswith("jquery") else [B + "js/" + f]
    else:
        folder = "videos" if f.endswith((".mp4", ".webm")) else "images"
        dest = f"{folder}/{clean(f)}"
        remote = [B + f, B + f.replace(" ", "%20")]
    shutil.copyfile(f"{SRC}/{f}", dest)
    for r in remote: mapping[r] = dest

# longest first so -p-500 etc. aren't clobbered by shorter prefixes
for r in sorted(mapping, key=len, reverse=True):
    html = html.replace(r, mapping[r])
    css = css.replace(r, "../" + mapping[r])
html = html.replace('<link href="https://cdn.prod.website-files.com" rel="preconnect" crossorigin="anonymous"/>', "")
html = html.replace('<meta content="Webflow" name="generator"/>', "")
open("index.html", "w", encoding="utf-8").write(html)
open("css/site.css", "w", encoding="utf-8").write(css)
left = set(re.findall(r"https://(?:cdn\.prod\.website-files\.com|d3e54v103j8qbb\.cloudfront\.net)[^\"' )]*", html + css))
print("copied", len(set(mapping.values())), "files; remaining Webflow refs:", left or "none")
