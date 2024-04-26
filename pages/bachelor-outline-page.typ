#import "@preview/outrageous:0.1.0"
#import "../utils/invisible-heading.typ": invisible-heading
#import "../utils/style.typ": 字号, 字体

// 本科生目录生成
#let bachelor-outline-page(
  // documentclass 传入参数
  twoside: true,
  fonts: (:),
  // 其他参数
  stroke-width: 0.5pt,
  depth: 4,
  outline-title: "目录",
  outlined: false,
  title-vspace: 0pt,
  title-text-args: auto,
  // 引用页数的字体，这里用于显示 Times New Roman
  reference-font: auto,
  reference-size: 字号.小四,
  // 字体与字号
  font: auto,
  size: (14pt, 13pt, 12pt),
  // 垂直间距
  vspace: (20pt, 16pt),
  indent: (0em, 1em, 1em),
  display-header: true,
  // 全都显示点号
  fill: (auto,),
  ..args,
) = {

  // 1.  默认参数
  fonts = 字体 + fonts
  if (title-text-args == auto) {
    title-text-args = (size: 字号.三号, weight: 600)
  }
  // 引用页数的字体，这里用于显示 Times New Roman
  if (reference-font == auto) {
    reference-font = fonts.宋体
  }
  // 字体与字号
  if (font == auto) {
    font = (fonts.黑体, fonts.宋体)
  }

  // 2.  正式渲染
  pagebreak(weak: true, to: if twoside { "odd" })

  // 3.  处理页码和页眉
  set page(footer: context[
    #set align(center)
    #set text(font:  fonts.宋体, size: 字号.五号)
    #counter(page).display("i")
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

  // 默认显示的字体
  set text(font: reference-font, size: reference-size)
  set align(center)

  text(..title-text-args, "目　录")

  // 标记一个不可见的标题用于目录生成
  invisible-heading(level: 1, outlined: outlined, outline-title)

  v(title-vspace)

  show outline.entry: outrageous.show-entry.with(
    // 保留 Typst 基础样式
    ..outrageous.presets.typst,
    body-transform: (level, it) => {
      // 设置字体和字号
      set text(size: size.at(calc.min(level, size.len()) - 1))
      // 计算缩进
      let indent-list = indent + range(level - indent.len()).map((it) => indent.last())
      let indent-length = indent-list.slice(0, count: level).sum()
      h(indent-length) + it
    },
    vspace: vspace,
    fill: fill,
    ..args,
  )

  // 重置页码
  counter(page).update(1)
  // 显示目录
  outline(title: none, depth: depth)
}