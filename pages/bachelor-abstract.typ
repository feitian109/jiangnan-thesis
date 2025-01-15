#import "../utils/style.typ": 字号
#import "../utils/invisible-heading.typ": invisible-heading
#import "../utils/custom-header.typ": custom-header
#import "../utils/indent.typ": fake-par

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
  set page(
    header: if display-header {
      custom-header(fonts.宋体, outline-title)
    },
  )

  // 标记一个不可见的标题用于 pdf 目录生成
  invisible-heading(level: 1, bookmarked: true, outlined: false, outline-title)

  // 标题
  {
    set text(spacing: 0.5em)
    heading(level: 1, bookmarked: false, outlined: false)[摘 要]
  }

  // 正文
  set text(font: fonts.宋体, size: 字号.小四)
  set par(first-line-indent: 2em, leading: leading, spacing: spacing, justify: true)
  fake-par
  body

  v(1.8em)

  //关键词
  text(weight: bold-level)[关键词：]
  (("",) + keywords.intersperse("；")).sum()

  pagebreak()
}