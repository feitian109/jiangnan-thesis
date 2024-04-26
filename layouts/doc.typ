// 文稿设置，可以进行一些像页面边距这类的全局设置
#let doc(
  // documentclass 传入参数
  info: (:),
  // 其他参数
  fallback: false, // 字体缺失时使用 fallback，不显示豆腐块
  lang: "zh",
  margin: (2cm),
  it,
) = {
  // 1.  基本的样式设置
  set text(fallback: fallback, lang: lang)

  // 2.  PDF 目录和元信息
  set heading(bookmarked: true)
  set document(title: (("",) + info.title).sum(), author: info.author)
  
  it
}