// 用于创建一个不可见的标题，用于给 outline 加上短标题
#let invisible-heading(..args) = {
  show heading: it => v(0pt)
  heading(numbering: none, ..args)
}