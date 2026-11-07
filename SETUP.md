# Somnium

Quartz 5 is configured with the Obsidian template and shortest-path wikilinks.

## Run locally

Open a new terminal after installing Node.js, then run:

```powershell
cd D:\Projekts\Somnium
npm ci
npm run dev
```

Visit http://localhost:8080. The preview rebuilds when content changes.
Use `npm run build` to generate the production site in `public/`.

## Write notes

Your existing Obsidian vault is `content/Somnium/`. Its notes are included in the
site. Edit `content/index.md` for the website homepage and `quartz.config.yaml`
for site settings. Obsidian settings, private folders, templates, and draft notes
are excluded by the configured filters.

## GitHub Pages

The deployment workflow is `.github/workflows/deploy.yml`. It builds the site
on pushes to `v5`, or when started manually through GitHub Actions.

To activate hosting, select **Settings > Pages > Source > GitHub Actions** in
https://github.com/skysliime/Somnium, then commit and push the setup and content.
The configured site address is https://skysliime.github.io/Somnium/.

Analytics is disabled. Search, graph, backlinks, popovers, dark mode, Obsidian
Markdown, math, and Excalidraw support are configured.
