---
author: "zhao qiang"
author_link: ""
title: "用 Hugo 搭配 Algolia 实现高效美观的站内搜索"
date: 2020-02-18T09:13:13+08:00
lastmod: 2020-02-18T09:13:13+08:00
draft: true
description: ""
show_in_homepage: true
description_as_summary: false
license: ""

tags: ["hugo",
"algolia"
]
categories: ["hugo"
]

featured_image: ""
featured_image_preview: ""

comment: true
toc: true
auto_collapse_toc: true
math: false
---

## 前言

很多的 Hugo 主题是没有自带搜索功能的，但是们为了方便用户浏览和查找内容是需要在网站上提供搜索功能。大家可以查看 [Hugo 官方推荐的搜索方案](https://gohugo.io/tools/search/)，这里我选择的是 Algolia， 折腾了很久，主题也从EVEN更新到了现在的LOVEIT，发现也并非很繁琐，以下是折腾后的成果。

[Algolia](https://www.algolia.com/)属于商业解决方案，但是提供了免费计划，对于我这种小站免费就够用了。

参考教程：

- [Add Algolia Search To Hugo Static Website](https://code.luasoftware.com/tutorials/algolia/add-algolia-search-to-hugo-static-website/)
- [Static site search with Hugo + Algolia](https://forestry.io/blog/search-with-algolia-in-hugo/)

### Algolia 中的配置

