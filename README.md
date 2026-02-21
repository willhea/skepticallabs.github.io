# skepticallabs.github.io

Source repo for [skepticallabs.com](https://skepticallabs.com)

## Hugo Static Site Generator

This site is built using [Hugo](https://gohugo.io/), a fast and flexible static site generator.

### Prerequisites

- **Local Development**: Hugo runs directly on your machine for fast iteration
- **Version Management**: Hugo version is specified in `.hugo-version`

**Install Hugo (if not already installed):**

- **macOS**: `brew install hugo`
- **Linux**: See [Hugo Installation Guide](https://gohugo.io/installation/linux/)
- **Windows**: See [Hugo Installation Guide](https://gohugo.io/installation/windows/)

Verify installation:
```bash
hugo version
```

**Quick Setup:**

```bash
# Complete setup (checks Hugo installation)
make setup

# Or verify manually:
make check-hugo
```

### Theme Setup

This site uses the [Blowfish](https://blowfish.page/) theme. The theme is already set up as a Git submodule.

If you need to reinstall the theme:

```bash
git submodule add -b main https://github.com/nunocoracao/blowfish.git themes/blowfish
```

Or if you prefer to clone the repository with submodules:

```bash
git clone --recurse-submodules <repository-url>
```

### Development

**Using Makefile (recommended):**

```bash
# Run development server
make server

# Run development server with drafts visible
make server-drafts

# Build the static site
make build

# Check Hugo installation and version
make check-hugo

# Clean generated files
make clean

# Show all available commands
make help
```

The site will be available at `http://localhost:1314` by default. The generated site will be in the `public/` directory.

**Direct Hugo commands:**

You can also use Hugo directly:

```bash
hugo server          # Development server
hugo server -D       # With drafts
hugo                 # Build site
```

### Project Structure

- `content/` - Site content (markdown files)
  - `_index.md` - Home page
  - `about.md` - About page
  - `contact.md` - Contact page
- `themes/` - Hugo themes
- `static/` - Static assets (CSS, images, etc.)
- `config.toml` - Hugo configuration file
- `.hugo-version` - Required Hugo version (minimum)
- `Makefile` - Build commands
- `public/` - Generated site (gitignored)

### Troubleshooting

**Hugo not found:**
- Install Hugo: `brew install hugo` (macOS) or see [installation guide](https://gohugo.io/installation/)
- Verify: `hugo version`

**Version mismatch:**
- The Makefile checks for minimum Hugo version
- Install a newer version if needed: `brew upgrade hugo`

**Port 1314 already in use:**
- Stop other Hugo servers or change port: `hugo server -p 1315`

**Theme errors:**
- Ensure theme is installed: `git submodule update --init --recursive`
- Check that Hugo version meets theme requirements (see `.hugo-version`)

### Deployment

The `public/` directory contains the generated static site and can be deployed to:
- GitHub Pages
- Netlify
- Vercel
- Any static hosting service

**Building for production:**

```bash
# Build the site locally
make build

# The public/ directory is ready for deployment
```

**GitHub Pages with GitHub Actions:**

You can use GitHub Actions to automatically build and deploy your site. Example workflow:

```yaml
name: Deploy to GitHub Pages

on:
  push:
    branches: [ main ]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
        with:
          submodules: true
      - name: Setup Hugo
        uses: peaceiris/actions-hugo@v2
        with:
          hugo-version: '0.155.3'
          extended: true
      - name: Build
        run: hugo
      - name: Deploy
        uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./public
```

### Benefits

- ✅ **Fast local development**: Hugo runs natively, no overhead
- ✅ **Version control**: Hugo version specified in `.hugo-version`
- ✅ **Simple workflow**: Direct Hugo commands for daily development
- ✅ **CI/CD ready**: Easy to integrate with GitHub Actions
