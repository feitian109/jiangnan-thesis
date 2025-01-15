#import "style.typ": 字号

#let custom-header(
  font,
  size: 字号.小五,
  stroke-width: 0.5pt,
  it,
) = {
  set text(font: font, size: size)
  align(
    center,
    stack(
      it,
      v(0.5em),
      line(length: 100%, stroke: stroke-width + black),
    ),
  )
}
