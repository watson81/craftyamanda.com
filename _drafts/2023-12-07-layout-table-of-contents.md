---
title: "Layout: Standard, With Table of Contents"
categories:
  - Sample Posts
tags:
  - Formatting
  - Standard Layout
toc: true
---

Auto-generated table of contents list for your posts and pages can be enabled by adding `toc: true` to the YAML Front
Matter.

Note: You need to use contiguous levels of headings for the TOC to generate properly. For example:

# Good headings

```md
# Heading
## Heading
### Heading
### Heading
# Heading
## Heading
```

# Bad headings

```md
# Heading
### Heading (skipped H2)
##### Heading (skipped H4)
```

# More options

## Label

Use `toc_label: "My Table of Contents"` to change the name of your TOC

## Icon

Use `toc_icon: cog` to change the icon used next to the TOC label. It can be any
[Font Awesome](https://fontawesome.com/v5/search?s=solid&m=free) icon.

## Sticky?

Use the `toc_sticky: true` to make the TOC stick to the top of the screen when scrolling, so it remains in view.

# Another Example

Yup. We needed some examples.

## A subheading
### A SUB-subheading
What good is a table of contents without sub-subheadings?
