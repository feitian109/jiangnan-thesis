#import "../utils/style.typ": 字号

// 前言，重置页面计数器
#let preface(
  // documentclass 传入的参数
  twoside: true,
  fonts: (:),
  // 其他参数
  it,
) = {
  // 分页
  if (twoside) {
    pagebreak()
  }

  // 设置页边距
  set page(
    // 设置前言部分的页码
    footer: context {
      set align(center)
      set text(font: fonts.宋体, size: 字号.五号)
      counter(page).display("I")
    },
  )

  // 自定义一级标题
  show heading: it => {
    if it.level == 1 {
      set text(font: fonts.宋体, size: 字号.三号)
      align(
        center,
        block(
          inset: (top: -0.4em, bottom: 0.4em),
          text(weight: "bold", it),
        ),
      )
    } else {
      it
    }
  }

  // 更新页码
  counter(page).update(1)
  it
}