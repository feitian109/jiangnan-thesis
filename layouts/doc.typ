#import "../utils/custom-cuti.typ": *

// 文稿设置，可以进行一些像页面边距这类的全局设置
#let doc(
  // documentclass 传入参数
  info: (:),
  // 其他参数
  fallback: false, // 字体缺失时使用 fallback，不显示豆腐块
  lang: "zh",
  it,
) = {
  // 1.  设置纸张
  set page(paper: "a4")

  // 2.  基本的样式设置
  set text(fallback: fallback, lang: lang)
  show: show-cn-fakebold

  // 3.  PDF 目录和元信息
  set heading(bookmarked: true)
  set document(title: (("",) + info.title).sum(), author: info.author)
  
  it
}