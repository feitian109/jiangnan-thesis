#import "../utils/invisible-heading.typ": invisible-heading

// 致谢页
#let acknowledgement(
  // documentclass 传入参数
  anonymous: false,
  // 其他参数
  title: "致　谢",
  outlined: true,
  outline-title: "致谢",
  body,
) = {
  if not anonymous {
    // 标记一个不可见的标题用于 pdf 目录生成
    invisible-heading(level: 1, bookmarked: true, outlined: true, outline-title)
    [
      #heading(level: 1, numbering: none, outlined: false, title)
    ]
    body
  }
}
