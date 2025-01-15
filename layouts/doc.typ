// 文稿设置，可以进行一些像页面边距这类的全局设置
#let doc(
  // documentclass 传入参数
  twoside: true,
  info: (:),
  // 其他参数
  fallback: false, // 字体缺失时使用 fallback，不显示豆腐块
  lang: "zh",
  paper: "a4",
  it,
) = {
  // 1.  基本的样式设置
  set text(fallback: fallback, lang: lang)
  set page(
    paper: paper,
    // 页边距
    margin: if twoside {
      (inside: 2cm + 0.5cm, outside: 2cm, y: 2cm)
    } else {
      2cm
    },
  )

  // 2.  PDF 元信息
  set document(
    title: (("",) + info.title).sum(),
    author: info.author,
  )

  it
}