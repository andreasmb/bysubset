# bysubset.com

Static copy of the Subset site, moved off Webflow. Plain HTML/CSS/JS, no build step.

- `index.html` — the page
- `css/`, `js/`, `images/`, `videos/` — all assets, served locally
- External services still in use: Wistia (desktop hero video), Google Fonts, Google Analytics, Sentry

## Preview locally

    python3 -m http.server 8000

then open http://localhost:8000

## Deploy

Hosted on GitHub Pages from `main`, custom domain in `CNAME`. Pushing to `main` deploys.
DNS for bysubset.com is managed at DreamHost.

## tools/

- `fetch-original.sh` — re-downloads the live Webflow source and assets into `_webflow-original/`
- `_build.py` — rewrites Webflow CDN URLs to local paths (run from the repo root)
