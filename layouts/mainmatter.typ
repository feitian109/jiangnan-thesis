#import "@preview/i-figured:0.2.4"
#import "../utils/style.typ": 字号, 字体
#import "../utils/custom-numbering.typ": custom-numbering
#import "../utils/indent.typ": fake-par
#import "../utils/unpairs.typ": unpairs

#let mainmatter(
  // documentclass 传入参数
  twoside: false,
  compact: false,
  fonts: (:),
  info: (:),
  // 其他参数
  leading: 1em,
  spacing: 1.25em,
  justify: true,
  first-line-indent: 2em,
  numbering: custom-numbering.with(first-level: "第1章 ", depth: 4, "1.1 "),
  // 正文字体与字号参数
  text-args: auto,
  // 标题字体与字号
  heading-font: auto,
  heading-size: (字号.三号, 字号.四号, 字号.小四),
  heading-weight: ("bold",),
  heading-above: (1.25em, 1.25em),
  heading-below: (1.25em, 1.25em),
  heading-pagebreak: (true, false),
  heading-align: (center, auto),
  // 页眉
  header-render: auto,
  display-header: true,
  stroke-width: 0.5pt,
  reset-footnote: true,
  // caption 的 separator
  separator: "  ",
  // caption 样式
  caption-size: 字号.五号,
  // figure 计数
  show-figure: i-figured.show-figure.with(numbering: "1-1"),
  // equation 计数
  show-equation: i-figured.show-equation.with(numbering: "(1-1)"),
  ..args,
  it,
) = {
  // 1.  默认参数
  if (text-args == auto) {
    text-args = (font: fonts.宋体, size: 字号.小四)
  }
  if (compact) {
    heading-pagebreak = (false, false)
  }
  
  // 1.1 字体与字号
  if (heading-font == auto) {
    heading-font = (fonts.宋体,)
  }
  // 1.2 处理 heading- 开头的其他参数
  let heading-text-args-lists = args.named().pairs()
  .filter((pair) => pair.at(0).starts-with("heading-"))
  .map((pair) => (pair.at(0).slice("heading-".len()), pair.at(1)))
  
  // 2.  辅助函数
  let array-at(arr, pos) = {
    arr.at(calc.min(pos, arr.len()) - 1)
  }
  
  // 3.  设置基本样式
  // 3.1 文本和段落样式
  set text(..text-args)
  set par(
    leading: leading,
    justify: justify,
    first-line-indent: first-line-indent,
  )
  show par: set block(spacing: spacing)
  // 3.2 脚注样式
  show footnote.entry: set text(font: fonts.宋体, size: 字号.小五)
  // 3.3 设置 figure 的编号
  show heading: i-figured.reset-counters
  show figure: show-figure
  // 3.4 设置 equation 的编号和假段落首行缩进
  show math.equation.where(block: true): show-equation
  // 3.5 表格表头置顶 + 不用冒号用空格分割 + 样式
  show figure.where(kind: table): set figure.caption(position: top)
  set figure.caption(separator: separator)
  show figure:set text(font: fonts.宋体, size: 字号.五号)
  
  // 3.6 优化列表显示
  //     术语列表 terms 不应该缩进
  show terms: set par(first-line-indent: 0pt)
  
  // 4.  处理标题
  // 4.1 设置标题的 Numbering
  set heading(numbering: numbering)
  // 4.2 设置字体字号并加入假段落模拟首行缩进
  show heading: it => {
    set text(
      font: array-at(heading-font, it.level),
      size: array-at(heading-size, it.level),
      weight: array-at(heading-weight, it.level),
      ..unpairs(heading-text-args-lists
      .map((pair) => (pair.at(0), array-at(pair.at(1), it.level)))),
      ..if (it.level == 1){
        (top-edge:"x-height")
      }
    )
    set block(
      above: array-at(heading-above, it.level),
      below: array-at(heading-below, it.level),
    )
    it
    fake-par
  }
  // 4.3 标题居中与自动换页
  show heading: it => {
    if (array-at(heading-pagebreak, it.level)) {
      // 如果打上了 no-2side-pagebreak 标签，则不会强制奇数页开始
      // 如果打上了 no-auto-pagebreak 标签，则不自动换页
      if (twoside) {
        if "label" in it.fields() and str(it.label) == "no-2side-pagebreak" {
          pagebreak(weak: true)
        } else if "label" in it.fields() and str(it.label) == "no-auto-pagebreak" {} else {
          pagebreak(to: "odd")
        }
      } else {
        if "label" in it.fields() and str(it.label) == "no-auto-pagebreak" {} else {
          pagebreak(weak: true)
        }
      }
    }
    
    if (array-at(heading-align, it.level) != auto) {
      set align(array-at(heading-align, it.level))
      it
    } else {
      it
    }
  }
  
  // 5.  处理页眉
  set page(
    numbering: "1",
    ..(
      if display-header {
        (
          header: {
            // 重置 footnote 计数器
            if reset-footnote {
              counter(footnote).update(0)
            }
            
            locate(
              loc => {
                set text(font: fonts.宋体, size: 字号.小五)
                align(
                  center,
                  stack(
                    if (calc.odd(loc.page())) { (("",) + info.title).sum() } else { info.doc-title },
                    v(0.4em),
                    line(length: 100%, stroke: stroke-width + black),
                  ),
                )
              },
            )
          },
        )
      } else {
        (header: { // 重置 footnote 计数器
          if reset-footnote { counter(footnote).update(0) }
        })
      }
    ),
  )
  
  set page(footer: context[
    #set align(center)
    #set text(font: fonts.宋体, size: 字号.五号)
    #counter(page).display("1")
  ])
  counter(page).update(1)
  it
}