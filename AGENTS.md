# AGENTS.md

Project context for Claude and other AI agents.

## Project Overview

**Site:** skepticallabs.com
**Stack:** Hugo static site generator + Blowfish theme
**Deployment:** GitHub Pages via GitHub Actions (gh-pages branch)

## Commands

```bash
make server        # Run dev server at http://localhost:1313
make server-drafts # Dev server with draft content
make build         # Build static site to public/
make clean         # Remove generated files
```

Or directly:
```bash
hugo server        # Dev server
hugo               # Build
```

## Content Structure

```
content/
  _index.md      # Home page
  about.md       # About page
  contact.md     # Contact page
  services.md    # Services page
```

## Configuration

- `config/_default/` - Hugo and Blowfish theme config (TOML)
- `static/CNAME` - Custom domain
- `static/llms.txt` - LLM discovery file
- `.hugo-version` - Required Hugo version

## Theme

Blowfish theme installed as git submodule in `themes/blowfish/`.
Documentation: https://blowfish.page/docs/

## Analytics

Uses **Cloudflare Web Analytics** (injected via `layouts/partials/extend-head.html`, production only). Do not suggest Google Analytics or other tracking systems.

## Deployment

Push to `main` triggers GitHub Actions workflow that:
1. Builds site with Hugo
2. Deploys to `gh-pages` branch
3. GitHub Pages serves from gh-pages with custom domain
