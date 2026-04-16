import { defineConfig } from "astro/config";
import mdx from "@astrojs/mdx";
import sitemap from "@astrojs/sitemap";

export default defineConfig({
  site: "https://apispen.com",
  integrations: [
    mdx(),
    sitemap(),
  ],
  build: {
    // Cloudflare Pages 최적화
    format: "directory",
  },
  markdown: {
    shikiConfig: {
      theme: "github-light",
    },
  },
});
