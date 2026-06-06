# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

`apispen.com` — the public showroom site for **APIS (아피스)**, a Korean marker & pen OEM manufacturer. It is a marketing/catalog site (not a store): products link out to Coupang for purchase, and the primary conversion goal is collecting B2B OEM inquiries. Built with **Astro 4 + Content Collections + MDX**, deployed as a static site to **Cloudflare Pages**, with **Pagefind** for client-side search.

UI text is **Korean**; code, identifiers, and frontmatter keys are English.

## Read this first

`docs/AGENTS.md` is the operating "constitution" for AI agents in this repo and its rules take precedence over any prompt. Most important constraints:

- **One unit of work per session** — add/edit a single product, category, or page. Do not bulk-delete or bulk-rewrite content files.
- **Never change an existing product/category `slug`** (= the filename / `id`) without an explicit decision and a matching 301 in `public/_redirects`. Slugs are live URLs; changing them breaks SEO.
- **`src/content/config.ts` enums are append-only.** Add new enum values; never remove existing ones (that's a breaking schema change).
- **Never change the operator contact** `apis1954@gmail.com` or swap Coupang Partners links for non-partner URLs.
- The product sort and per-page filter rules in `AGENTS.md` §3–4 are the source of truth; the page components implement them.

## Commands

```bash
npm install            # install deps
npm run dev            # dev server at http://localhost:4321
npm run build          # production build → dist/
npm run preview        # preview the built dist/
npm run pagefind       # build Pagefind search index over dist/ (run AFTER build)
```

There is **no test runner and no linter** configured. The de-facto check before pushing is that `npm run build` succeeds (Astro type-checks Content Collections against the Zod schema at build time, so a bad frontmatter field fails the build). Reproduce the production pipeline locally with `npm run build && npm run pagefind`.

## Deploy

`.github/workflows/deploy.yml` runs on push to `main`: install → build → pagefind → `wrangler pages deploy dist` to the Cloudflare Pages project `apispen-site`. Requires repo secrets `CLOUDFLARE_API_TOKEN` and `CLOUDFLARE_ACCOUNT_ID`. `public/_headers` (security headers) and `public/_redirects` (www→apex canonicalization, 301s, 404 fallback) are copied verbatim into `dist/` and applied by Cloudflare.

## Architecture

### Content is the database

There is no backend. All data lives in `src/content/` as files, validated by Zod schemas in `src/content/config.ts`. Three collections:

- **`products`** (`type: "content"`, MDX) — `src/content/products/*.mdx`. Frontmatter = structured product data (see schema); the MDX body is rendered as long-form description on the detail page. Filename convention: `apis-[feature]-[name].mdx`; the filename becomes the URL slug.
- **`categories`** (`type: "data"`, YAML) — `src/content/categories/*.yaml`. The file `id` is the category's URL slug.
- **`notices`** (`type: "content"`, MDX) — announcements/blog.

When adding/editing products or categories, follow `docs/PRODUCT_SCHEMA_v2.md` and `docs/CATEGORY_SCHEMA_v2.md`, and keep every field aligned with the Zod schema — anything not in the schema (or wrong type) breaks `npm run build`.

### Two separate taxonomies — don't confuse them

This is the easiest thing to get wrong:

- **`category`** (product field, e.g. `permanent-marker`, `name-pen`) — the fine-grained product type. Drives the emoji icon maps in the page components and the displayed breadcrumb/label.
- **`primary_sales_group`** (product field, e.g. `marker-core`) — the coarse grouping used for **routing/filtering** products into category pages.

A **category page** (`/categories/[slug]`) collects products by matching `product.primary_sales_group === category.sales_focus_group` — **not** by `product.category` and **not** by the category's filename slug. So a category's URL (`core-markers`), its `sales_focus_group` (`marker-core`), and a product's `category` (`permanent-marker`) are three distinct identifiers that must be kept consistent via the schema enums and `AGENTS.md` §5.

### Page generation & ranking

- `src/pages/index.astro` — home. Shows up to 8 products where `home_featured && menu_visibility === "primary"`, plus active categories ordered by `display_order`.
- `src/pages/categories/index.astro` and `[slug].astro` — category list and detail; `[slug]` uses `getStaticPaths` over categories.
- `src/pages/products/[slug].astro` — product detail; `getStaticPaths` over active products, renders frontmatter specs table + `<Content />` (the MDX body).
- `src/pages/oem.astro`, `src/pages/notices/index.astro`.

Everywhere products are listed, the **standard sort** is: `apis_launch_order` asc → `sales_priority` desc → (`search_boost` desc). `apis_launch_order` must be unique per product; the value's band signals the launch stage (1–10 core, 11–20 growth, 21–40 expansion, 41–60 OEM-only — see `AGENTS.md` §3). Lists are pre-filtered by `is_active`.

### Shared layout & styling

`src/layouts/BaseLayout.astro` wraps every page: `<head>` SEO/OG/Twitter meta (canonical URL derived from `Astro.site` in `astro.config.mjs`), Pagefind UI assets, the global stylesheet, header, and footer. Pass `title`/`description`/`ogImage`/`noIndex` props. Styling is **inline styles + a small set of CSS custom properties** defined in BaseLayout (`--apis-primary`, `--apis-accent`, `--apis-gold`, `--apis-light`, `--apis-gray`, `--apis-border`, etc.) and a few utility classes (`.container`, `.section`, `.section-title`, `.bg-light`). There is no CSS framework or component library — reuse the existing tokens and inline-style patterns rather than introducing new ones.

### Conventions

- Outbound Coupang links always use `target="_blank" rel="noopener noreferrer nofollow"`, and inside a card wrapper add `onclick="event.stopPropagation();"` so the affiliate link doesn't trigger the card's navigation.
- The `@/*` path alias maps to `src/*` (`tsconfig.json`, `astro/tsconfigs/strict`).
- Images: WebP preferred, `alt` required.
