#import "../utils/style.typ": 字号
#import "../utils/invisible-heading.typ": invisible-heading

// 本科生中文摘要页
#let bachelor-abstract(
  // documentclass 传入的参数
  display-header: true,
  twoside: true,
  fonts: (:),
  // 其他参数
  keywords: (),
  outline-title: "摘要",
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
  set page(header: if display-header {
    set text(font: fonts.宋体, size: 字号.小五)
    align(center, stack(outline-title, v(0.4em), line(length: 100%, stroke: stroke-width)))
  })

  // 标记一个不可见的标题用于 pdf 目录生成
  invisible-heading(level: 1, bookmarked: true, outlined: false, outline-title)

  // 标题
  set par(spacing: 0pt)
  align(
    center,
    text(font: fonts.宋体, size: 字号.三号, weight: bold-level, spacing: 0.5em, baseline: -0.3em)[摘 要],
  )

  // 正文
  set text(font: fonts.宋体, size: 字号.小四)
  set par(first-line-indent: 2em, leading: leading, spacing: spacing, justify: true)
  body

  v(1em)

  //关键词
  text(weight: bold-level)[关键词：]
  (("",) + keywords.intersperse("；")).sum()

  pagebreak()
}