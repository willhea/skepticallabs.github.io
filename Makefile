.PHONY: help check-hugo server server-drafts build clean setup

# Hugo version from .hugo-version file
HUGO_VERSION := $(shell cat .hugo-version 2>/dev/null || echo "latest")
HUGO_CMD := hugo
HUGO_PORT := 1314

help: ## Show this help message
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Available targets:'
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  %-15s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

check-hugo: ## Check if Hugo is installed and matches required version
	@if ! command -v $(HUGO_CMD) > /dev/null 2>&1; then \
		echo "❌ Hugo is not installed."; \
		echo "   Install Hugo version $(HUGO_VERSION) or run: brew install hugo"; \
		exit 1; \
	fi
	@INSTALLED_VERSION=$$($(HUGO_CMD) version | grep -oE 'v[0-9]+\.[0-9]+\.[0-9]+' | head -1 | sed 's/v//'); \
	REQUIRED_VERSION="$(HUGO_VERSION)"; \
	if [ -n "$$INSTALLED_VERSION" ] && [ -n "$$REQUIRED_VERSION" ] && [ "$$REQUIRED_VERSION" != "latest" ]; then \
		INSTALLED_MAJOR=$$(echo $$INSTALLED_VERSION | cut -d. -f1); \
		INSTALLED_MINOR=$$(echo $$INSTALLED_VERSION | cut -d. -f2); \
		REQUIRED_MAJOR=$$(echo $$REQUIRED_VERSION | cut -d. -f1); \
		REQUIRED_MINOR=$$(echo $$REQUIRED_VERSION | cut -d. -f2); \
		if [ $$INSTALLED_MAJOR -lt $$REQUIRED_MAJOR ] || ([ $$INSTALLED_MAJOR -eq $$REQUIRED_MAJOR ] && [ $$INSTALLED_MINOR -lt $$REQUIRED_MINOR ]); then \
			echo "⚠️  Warning: Hugo version may be too old"; \
			echo "   Installed: $$INSTALLED_VERSION"; \
			echo "   Required:  $$REQUIRED_VERSION (minimum)"; \
		fi \
	fi
	@echo "✅ Hugo is installed: $$($(HUGO_CMD) version | head -1)"

server: check-hugo ## Run Hugo development server locally
	@echo "Starting Hugo development server..."
	@echo "Site will be available at http://localhost:$(HUGO_PORT)"
	$(HUGO_CMD) server -p $(HUGO_PORT)

server-drafts: check-hugo ## Run Hugo development server with drafts
	@echo "Starting Hugo development server with drafts..."
	@echo "Site will be available at http://localhost:$(HUGO_PORT)"
	$(HUGO_CMD) server -D -p $(HUGO_PORT)

build: check-hugo ## Build the static site
	@echo "Building static site..."
	$(HUGO_CMD)
	@echo "✅ Site built in public/ directory"

clean: ## Remove generated files
	rm -rf public/
	rm -rf resources/
	rm -f .hugo_build.lock
	@echo "✅ Cleaned generated files"

setup: check-hugo ## Complete setup: verify Hugo installation
	@echo "✅ Setup complete!"
	@echo ""
	@echo "Hugo version: $$($(HUGO_CMD) version | head -1)"
	@echo ""
	@echo "Next steps:"
	@echo "  1. Run server: make server"
	@echo "  2. Build site: make build"
