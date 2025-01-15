#import "../utils/style.typ": 字号
#import "../utils/invisible-heading.typ": invisible-heading
#import "../utils/custom-header.typ": custom-header

// 本科生英文摘要页
#let bachelor-abstract-en(
  // documentclass 传入的参数
  display-header: true,
  twoside: true,
  fonts: (:),
  // 其他参数
  keywords: (),
  outline-title: "ABSTRACT",
  leading: 1em,
  spacing: 1em,
  stroke-width: 0.5pt,
  bold-level: "bold",
  body,
) = {
  // 双页显示
  if twoside {
    pagebreak(weak: true, to: "odd")
  }

  // 处理页眉
  set page(
    header: if display-header {
      custom-header(fonts.宋体, outline-title)
    },
  )

  // 标记一个不可见的标题用于 pdf 目录生成
  invisible-heading(level: 1, bookmarked: true, outlined: false, outline-title)

  // 标题
  set par(spacing: 0pt)
  align(
    center,
    text(font: fonts.宋体, size: 字号.三号, weight: bold-level, baseline: -0.3em)[ABSTRACT],
  )

  // 正文
  set text(font: fonts.宋体, size: 字号.小四)
  set par(first-line-indent: 2em, leading: leading, spacing: spacing, justify: true)
  body

  v(1em)

  //关键词
  text(weight: bold-level)[Keywords：]
  (("",) + keywords.intersperse("; ")).sum()

  pagebreak()
}