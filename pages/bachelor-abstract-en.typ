#import "../utils/style.typ": 字号, 字体
#import "../utils/indent.typ": fake-par
#import "../utils/invisible-heading.typ": invisible-heading

// 本科生英文摘要页
#let bachelor-abstract-en(
  // documentclass 传入的参数
  anonymous: false,
  twoside: true,
  fonts: (:),
  info: (:),
  // 其他参数
  stroke-width: 0.5pt,
  keywords: (),
  outline-title: "ABSTRACT",
  outlined: false,
  leading: 1em,
  spacing: 1em,
  bold-level: 600,
  display-header: true,
  header-render: auto,
  header-vspace: 0em,
  body,
) = {
  // 1.  默认参数
  fonts = 字体 + fonts

  // 2.  正式渲染
  pagebreak(weak: true, to: if twoside { "even" })

  // 3.  处理页眉
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
    #text(size: 字号.三号, weight: bold-level)[ABSTRACT]
  ]

  fake-par
  body

  v(1em)

  text(weight: bold-level)[Keywords: ]
  (("",) + keywords.intersperse("; ")).sum()
}