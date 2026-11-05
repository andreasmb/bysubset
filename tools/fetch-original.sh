#!/bin/bash
# Downloads the live Webflow source of bysubset.com and every asset it uses
# into _webflow-original/, so the site can be rebuilt without Webflow.
set -e
cd "$(dirname "$0")/.."
mkdir -p _webflow-original
cd _webflow-original
B="https://cdn.prod.website-files.com/623f9a8de8e7ac3a9e6b5d8c"
get() { echo "  $2"; curl -fsSL -A "Mozilla/5.0" "$1" -o "$2"; }
echo "Downloading bysubset.com…"
get "https://www.bysubset.com/" index.html
get "$B/css/subsets-beautiful-site.webflow.shared.5416cad54.css" site.css
get "https://d3e54v103j8qbb.cloudfront.net/js/jquery-3.5.1.min.dc5e7f18c8.js?site=623f9a8de8e7ac3a9e6b5d8c" jquery-3.5.1.min.js
get "$B/js/webflow.schunk.36b8fb49256177c8.js" webflow.schunk.36b8fb49256177c8.js
get "$B/js/webflow.schunk.3b58b0126ec020df.js" webflow.schunk.3b58b0126ec020df.js
get "$B/js/webflow.b60bdfd1.00f6ebf4665a3508.js" webflow.b60bdfd1.00f6ebf4665a3508.js
for f in \
  "63e5f647741fba51eb3bb49b_subset%20favicon.png" \
  "63e5f683535a980f7abf863b_subset%20favicon%20256.png" \
  624147fb9ebd401dade24864_decoration01.png \
  624147fa8e4876af66778fc7_decoration02.png \
  638c533ec239dee0f4c32150_decoration03.png \
  638c4c62de3590258d5ff610_decoration05.png \
  638c4c6210a6ce9fa55b8cb9_decoration06.png \
  638c4c63698caab3705102a9_decoration07.png \
  62453645b66c13dc181d68c1_decoration08.png \
  62453950acdce2f9784af317_decoration08-smaller.png \
  62454a25006c0053765b2ad5_ml-animation.png \
  624677ac6ae3205214f1a0c8_ml-animation-larger.png \
  624536ecc3e61d0a036d9449_visual_no-circle.png \
  638c5848de35905c34607c01_subset-live-web.jpg \
  638c5848de35905c34607c01_subset-live-web-p-500.jpg \
  638c5848de35905c34607c01_subset-live-web-p-800.jpg \
  638b02682a2fb8385cf24897_subset-live2-web.jpg \
  638b02682a2fb8385cf24897_subset-live2-web-p-500.jpg \
  638b02682a2fb8385cf24897_subset-live2-web-p-800.jpg \
  638b02682a2fb8385cf24897_subset-live2-web-p-1080.jpg \
  638b02682a2fb8385cf24897_subset-live2-web-p-1600.jpg \
  638b02682a2fb8385cf24897_subset-live2-web-p-2000.jpg \
  "63e5f2e21ce114382994e12f_%20subset-mobile-2023-poster-00001.jpg" \
  "63e5f2e21ce114382994e12f_%20subset-mobile-2023-transcode.mp4" \
  "63e5f2e21ce114382994e12f_%20subset-mobile-2023-transcode.webm"
do
  get "$B/$f" "$(echo "$f" | sed 's/%20/ /g')"
done
echo "Done: $(ls | wc -l | tr -d ' ') files in _webflow-original/"
