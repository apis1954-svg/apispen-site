import { defineCollection, z } from "astro:content";

// ── 제품 컬렉션 스키마 ─────────────────────────────────────────
const products = defineCollection({
  type: "content",
  schema: z.object({
    // 식별자
    id: z.string(),
    slug: z.string().optional(),

    // 분류
    category: z.enum([
      "permanent-marker",
      "name-pen",
      "board-marker",
      "highlighter",
      "fabric-marker",
      "washable-marker",
      "functional-marker",
      "waterbased-sign-pen",
      "acrylic-marker",
      "marker-set",
      "oem-item",
    ]),
    primary_sales_group: z.enum([
      "marker-core",
      "marker-office",
      "marker-creative",
      "marker-functional",
      "sign-pen-waterbased",
      "oem-support",
    ]),

    // 출시 단계
    apis_launch_stage: z.enum(["core", "growth", "expansion", "oem-only"]),
    apis_launch_order: z.number().int().positive(),

    // 노출 설정
    home_featured: z.boolean().default(false),
    oem_featured: z.boolean().default(false),
    menu_visibility: z.enum(["primary", "secondary", "hidden"]).default("primary"),

    // 제품 정보
    title: z.string(),
    title_short: z.string().optional(),
    subtitle: z.string().optional(),
    description: z.string(),

    // 상세 스펙
    specs: z
      .object({
        ink_type: z.enum(["유성", "수성", "아크릴", "UV", "형광"]).optional(),
        tip_type: z.enum(["bullet", "chisel", "fine", "brush", "dual"]).optional(),
        tip_size_mm: z.number().optional(),
        colors_available: z.array(z.string()).default([]),
        quantity_per_pack: z.number().int().optional(),
        moq_oem: z.number().int().optional(),
        certifications: z.array(z.string()).default([]),
        storage_temp: z.string().optional(),
        made_in: z.string().default("Korea"),
      })
      .optional(),

    // 판매 채널
    coupang_url: z.string().default(""),
    coupang_partners: z.boolean().default(true),

    // SEO
    seo_title: z.string().optional(),
    seo_description: z.string().optional(),
    seo_keywords: z.array(z.string()).default([]),
    og_image: z.string().optional(),
    search_boost: z.number().int().min(1).max(10).default(5),

    // 내부 운영
    sales_priority: z.number().int().min(1).max(10).default(5),
    is_active: z.boolean().default(true),
    created_at: z.string().optional(),
    updated_at: z.string().optional(),
  }),
});

// ── 카테고리 컬렉션 스키마 ────────────────────────────────────
const categories = defineCollection({
  type: "data",
  schema: z.object({
    id: z.string(),
    slug: z.string().optional(),
    title: z.string(),
    title_en: z.string().optional(),
    subtitle: z.string().optional(),
    description: z.string(),
    sales_focus_group: z.enum([
      "marker-core",
      "marker-office",
      "marker-creative",
      "marker-functional",
      "sign-pen-waterbased",
      "oem-support",
    ]),
    included_categories: z.array(z.string()).default([]),
    icon: z.string().optional(),
    display_order: z.number().int().default(99),
    hero_color: z.string().default("#e94560"),
    is_active: z.boolean().default(true),
    seo_title: z.string().optional(),
    seo_description: z.string().optional(),
    og_image: z.string().optional(),
  }),
});

// ── 공지사항 컬렉션 스키마 ────────────────────────────────────
const notices = defineCollection({
  type: "content",
  schema: z.object({
    title: z.string(),
    tag: z.enum(["신제품", "OEM", "공지", "이벤트", "업데이트"]),
    date: z.string(),
    excerpt: z.string().optional(),
    is_featured: z.boolean().default(false),
    is_active: z.boolean().default(true),
  }),
});

export const collections = { products, categories, notices };
