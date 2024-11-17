#import "@preview/outrageous:0.1.0"
#import "../utils/invisible-heading.typ": invisible-heading
#import "../utils/style.typ": 字号

// 本科生目录生成
#let bachelor-outline-page(
  // documentclass 传入参数
  display-header: true,
  twoside: true,
  fonts: (:),
  // 其他参数
  depth: 3,
  title: "目　录",
  title-vspace: 字号.四号 * 1.25,
  title-text-args: auto,
  outline-title: "目录",
  bold-level: "bold",
  stroke-width: 0.5pt,
  // 引用页数的字体，这里用于显示 Times New Roman
  reference-font: auto,
  reference-size: 字号.小四,
  // 字体与字号
  font: auto,
  size: (字号.四号, 字号.小四, 字号.五号),
  // 垂直间距
  vspace: (1.25em, 1.25em),
  indent: (0em, 1em, 1em),
  // 全都显示点号
  fill: (auto,),
  ..args,
) = {
  // 1.  默认参数
  if (title-text-args == auto) {
    title-text-args = (font: fonts.宋体, size: 字号.三号, weight: bold-level, baseline: -0.3em)
  }

  // 引用页数的字体，这里用于显示 Times New Roman
  if (reference-font == auto) {
    reference-font = fonts.宋体
  }

  // 字体与字号
  if (font == auto) {
    font = (fonts.宋体,)
  }

  // 2.  处理页码和页眉
  set page(
    footer: context {
      set align(center)
      set text(font: fonts.宋体, size: 字号.五号)
      counter(page).display("i")
    },
    header: if display-header {
      set text(font: fonts.宋体, size: 字号.小五)
      align(center, stack(outline-title, v(0.4em), line(length: 100%, stroke: stroke-width)))
    },
  )

  // 3.  正式渲染
  // 双页显示
  if twoside {
    pagebreak(weak: true, to: "odd")
  }

  // 重置页码
  counter(page).update(1)

  // 标记一个不可见的标题用于 pdf 目录生成
  invisible-heading(level: 1, bookmarked: true, outlined: false, outline-title)

  align(center, text(..title-text-args, title))

  v(title-vspace)

  // 默认显示的字体
  set text(font: reference-font, size: reference-size)

  show outline.entry: outrageous
    .show-entry
    .with(
    // 保留 Typst 基础样式
    ..outrageous.presets.typst,
    body-transform: (level, it) => {
      // 设置字体和字号
      set text(
        font: font.at(calc.min(level, font.len()) - 1),
        size: size.at(calc.min(level, size.len()) - 1),
      )
      // 计算缩进
      let indent-list = indent + range(level - indent.len()).map((it) => indent.last())
      let indent-length = indent-list.slice(0, count: level).sum()
      h(indent-length) + it
    },
    vspace: vspace,
    fill: fill,
    ..args,
  )

  // 显示目录
  outline(title: none, depth: depth)

  pagebreak()
}