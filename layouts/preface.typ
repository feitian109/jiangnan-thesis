#import "../utils/style.typ": 字体, 字号

#let preface(fonts: (:), twoside: true, it) = {
  // 边距
  set page(
    margin: if (twoside) {
      (x: 2cm, inside: 2cm + 0.5cm, outside: 2cm)
    } else {
      (x: 2cm, y: 2cm)
    },
    //设置前言页码
    footer: context[
      #set align(center)
      #set text(font: fonts.宋体, size: 字号.五号)
      #counter(page).display("I")
    ],
  )
   
  it
}