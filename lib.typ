#import "layouts/doc.typ": doc
#import "layouts/preface.typ": preface
#import "layouts/mainmatter.typ": mainmatter
#import "layouts/appendix.typ": appendix

#import "pages/fonts-display-page.typ": fonts-display-page
#import "pages/bachelor-cover.typ": bachelor-cover
#import "pages/bachelor-abstract.typ": bachelor-abstract
#import "pages/bachelor-abstract-en.typ": bachelor-abstract-en
#import "pages/bachelor-outline-page.typ": bachelor-outline-page
#import "pages/coursework-cover.typ": coursework-cover
#import "pages/acknowledgement.typ": acknowledgement

#import "utils/bilingual-bibliography.typ": bilingual-bibliography
#import "utils/indent.typ": indent
#import "utils/hline.typ": hline
#import "utils/style.typ": 字体, 字号

// 使用函数闭包特性，通过 `documentclass` 函数类进行全局信息配置，然后暴露出拥有了全局配置的、具体的 `layouts` 和 `templates` 内部函数。
#let documentclass(
  // bachelor 或 coursework
  doctype: "bachelor",
  display-header: true, // 显示页眉
  twoside: true, // 双面模式，会加入空白页，便于打印
  compact: false,
  bibliography: none, // 参考文献函数
  fonts: (:), // 字体，应传入「宋体」、「黑体」、「楷体」、「仿宋」、「等宽」
  info: (:),
) = {
  // 默认参数
  fonts = 字体 + fonts
  info = (
    department: "通信与控制工程",
    major: "自动化",
    student-id: "34567890",
    author: "梁溪媛",
    year: 1234,
    month: 5,
  ) + info

  if (doctype == "bachelor") {
    info.doc-title = "江南大学学士学位论文"
    info = (
      title: ("本科毕业设计（论文）题目", ""),
      supervisor: ("常广溪", "教授"),
      supervisor-ii: (),
    ) + info
  }

  if (doctype == "coursework") {
    info = (
      title: ("江南大学课程设计题目", ""),
      doc-title: "江南大学课程设计",
      supervisor: (),
      supervisor-ii: (),
    ) + info
  }

  // 预处理部分
  // 1.  如果标题是字符串，则使用换行符将标题分隔为列表
  if type(info.title) == str {
    info.title = info.title.split("\n")
  }

  (
    // 将传入参数再导出
    doctype: doctype,
    display-header: display-header,
    twoside: twoside,
    compact: compact,
    bibliography: bibliography,
    fonts: fonts,
    info: info,
    // 页面布局
    doc: (..args) => {
      doc(..args, info: info + args.named().at("info", default: (:)))
    },
    // 前言
    preface: (..args) => {
      preface(..args, fonts: fonts + args.named().at("fonts", default: (:)),twoside:twoside)
    },
    // 正文
    mainmatter: (..args) => {
      mainmatter(
        ..args,
        twoside: twoside,
        compact: compact,
        display-header: display-header,
        fonts: fonts + args.named().at("fonts", default: (:)),
        info: info + args.named().at("info", default: (:)),
      )
    },
    // 附录
    appendix: (..args) => {
      appendix(..args, display-header: display-header)
    },
    // 字体展示页
    fonts-display-page: (..args) => {
      fonts-display-page(
        ..args,
        twoside: twoside,
        fonts: fonts + args.named().at("fonts", default: (:)),
      )
    },
    // 封面
    cover: (..args) => {
      if (doctype == "bachelor") {
        bachelor-cover(
          ..args,
          twoside: twoside,
          fonts: fonts + args.named().at("fonts", default: (:)),
          info: info + args.named().at("info", default: (:)),
        )
      } else if (doctype == "coursework") {
        coursework-cover(
          ..args,
          twoside: twoside,
          fonts: fonts + args.named().at("fonts", default: (:)),
          info: info + args.named().at("info", default: (:)),
        )
      }
    },
    // 中文摘要
    abstract: (..args) => {
      if (doctype in ("bachelor", "coursework")) {
        bachelor-abstract(
          ..args,
          twoside: twoside,
          display-header: display-header,
          fonts: fonts + args.named().at("fonts", default: (:)),
        )
      }
    },
    // 英文摘要
    abstract-en: (..args) => {
      if (doctype in ("bachelor", "coursework")) {
        bachelor-abstract-en(
          ..args,
          twoside: twoside,
          display-header: display-header,
          fonts: fonts + args.named().at("fonts", default: (:)),
        )
      }
    },
    // 目录
    outline-page: (..args) => {
      bachelor-outline-page(
        ..args,
        twoside: twoside,
        display-header: display-header,
        fonts: fonts + args.named().at("fonts", default: (:)),
      )
    },
    // 参考文献
    bilingual-bibliography: (..args) => {
      bilingual-bibliography(..args,
      fonts: fonts + args.named().at("fonts", default: (:)),)
    },
    // 致谢
    acknowledgement: (..args) => {
      acknowledgement(..args,
      fonts: fonts + args.named().at("fonts", default: (:))
      )
    },
  )
}
