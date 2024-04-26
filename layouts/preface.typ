#import "../utils/style.typ": 字体, 字号

#let preface(fonts: (:), it) = {
  //设置前言页码
  set page(footer: context[
    #set align(center)
    #set text(font: fonts.宋体, size: 字号.五号)
    #counter(page).display("I")
  ])

  it
}