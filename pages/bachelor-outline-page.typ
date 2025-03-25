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
  above: (1.45em, 1.25em),
  below: (1.45em, 1.25em),
  indent: (0em, 1em, 1em),
  // 全都显示点号
  fill: (repeat([.], gap: 0.15em),),
  gap: .3em,
  ..args,
) = {
  // 1.  默认参数
  // 引用页数的字体，这里用于显示 Times New Roman
  if reference-font == auto {
    reference-font = fonts.宋体
  }

  // 字体与字号
  if font == auto {
    font = (fonts.宋体,)
  }

  // 双页显示
  // 注意：必须在设置页码样式之前
  if twoside {
    pagebreak(weak: true, to: "odd")
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
  // 重置页码
  counter(page).update(1)

  // 标记一个不可见的标题用于 pdf 目录生成
  invisible-heading(level: 1, bookmarked: true, outlined: false, outline-title)

  // 标题
  heading(level: 1, bookmarked: false, outlined: false, title)

  v(title-vspace)

  // 默认显示的字体
  set text(font: reference-font, size: reference-size)

  // 目录样式
  set outline(indent: level => indent.slice(0, calc.min(level + 1, indent.len())).sum())
  show outline.entry: entry => block(
    above: above.at(entry.level - 1, default: above.last()),
    below: below.at(entry.level - 1, default: below.last()),
    link(
      entry.element.location(),
      entry.indented(
        none,
        {
          text(
            font: font.at(entry.level - 1, default: font.last()),
            size: size.at(entry.level - 1, default: size.last()),
            {
              if entry.prefix() not in (none, []) {
                entry.prefix()
                h(gap)
              }
              entry.body()
            },
          )
          box(width: 1fr, inset: (x: .25em), fill.at(entry.level - 1, default: fill.last()))
          entry.page()
        },
        gap: 0pt,
      ),
    ),
  )

  // 显示目录
  outline(title: none, depth: depth)

  pagebreak()
}