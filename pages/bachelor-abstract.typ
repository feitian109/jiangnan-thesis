#import "../utils/style.typ": 字号, 字体
#import "../utils/indent.typ": fake-par
#import "../utils/invisible-heading.typ": invisible-heading

// 本科生中文摘要页
#let bachelor-abstract(
  // documentclass 传入的参数
  twoside: true,
  fonts: (:),
  info: (:),
  display-header: true,
  // 其他参数
  keywords: (),
  stroke-width: 0.5pt,
  outline-title: "摘要",
  outlined: false,
  leading: 1em,
  spacing: 1em,
  bold-level: 600,
  body,
) = {
  // 1.  默认参数
  fonts = 字体 + fonts

  // 2.  正式渲染
  pagebreak(weak: true, to: if twoside { "odd" })

  // 3.  处理页眉
  set page(footer: context[
    #set align(center)
    #set text(font: fonts.宋体, size: 字号.五号)
    #counter(page).display("I")
  ],
    
    ..(if display-header {
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
    #text(size: 字号.三号, weight: bold-level)[摘　要]
  ]

  fake-par
  body

  v(1em)

  text(weight: bold-level)[关键词：]
  (("",) + keywords.intersperse("；")).sum()

  // 页码重置
  counter(page).update(1)
}