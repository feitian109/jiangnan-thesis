#import "@preview/i-figured:0.2.4"
#import "../utils/custom-numbering.typ": custom-numbering
#import "../utils/custom-header.typ": custom-header
#import "../utils/style.typ": 字号

// 后记，重置 heading 计数器
#let appendix(
  display-header: true,
  fonts: (:),
  numbering: custom-numbering.with(first-level: "", depth: 4, "1.1 "),
  // figure 计数
  show-figure: i-figured.show-figure.with(numbering: "1-1"),
  // equation 计数
  show-equation: i-figured.show-equation.with(numbering: "(1-1)"),
  // 重置计数
  reset-counter: false,
  it,
) = {
  set heading(numbering: numbering)
  if reset-counter {
    counter(heading).update(0)
  }
  // 设置 figure 的编号
  show figure: show-figure
  // 设置 equation 的编号
  show math.equation.where(block: true): show-equation

  // 页眉
  set page(
    header: if display-header {
      custom-header(fonts.宋体)[附录]
    },
  )

  it
}
