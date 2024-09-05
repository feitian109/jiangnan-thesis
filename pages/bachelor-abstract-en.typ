#import "../utils/style.typ": 字号, 字体
#import "../utils/indent.typ": fake-par
#import "../utils/invisible-heading.typ": invisible-heading

// 本科生英文摘要页
#let bachelor-abstract-en(
  // documentclass 传入的参数
  twoside: true,
  fonts: (:),
  info: (:),
  display-header: true,
  // 其他参数
  keywords: (),
  stroke-width: 0.5pt,
  outline-title: "ABSTRACT",
  outlined: false,
  leading: 1em,
  spacing: 1.25em,
  bold-level: "bold",
  body,
) = {
  // 1.  正式渲染
  pagebreak(weak: true, to: if twoside { "even" })

  // 2.  处理页眉
  set page(..(if display-header {
    (header: {
      set text(font: fonts.宋体, size: 字号.小五)
      align(center, stack(
        outline-title,
        v(0.4em),
        line(length: 100%, stroke: stroke-width + black),
      ))
    })
  }))

  set text(font: fonts.宋体, size: 字号.小四)
  set par(first-line-indent: 2em, leading: leading, justify: true)
  show par: set block(spacing: spacing)

  // 标记一个不可见的标题用于目录生成
  invisible-heading(level: 1, outlined: outlined, outline-title)

  align(center)[
    #text(size: 字号.三号, weight: bold-level, top-edge: "x-height")[ABSTRACT]
  ]

  fake-par
  body

  v(1em)

  text(weight: bold-level)[Keywords: ]
  (("",) + keywords.intersperse("; ")).sum()
}