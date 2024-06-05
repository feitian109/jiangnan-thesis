#import "../utils/style.typ": 字体, 字号

#let preface(fonts: (:), twoside: true, it) = {
  //设置前言页码
  set page(margin: if (twoside) {
    (x: 2cm, y: 2cm, inside: 1.5cm)
  } else {
    (x: 2cm, y: 2cm)
  }, footer: context[
    #set align(center)
    #set text(font: fonts.宋体, size: 字号.五号)
    #counter(page).display("I")
  ])
   
  it
}