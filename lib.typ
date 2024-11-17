#import "@preview/anti-matter:0.0.2": anti-inner-end as mainmatter-end
#import "layouts/doc.typ": doc
#import "layouts/preface.typ": preface
#import "layouts/mainmatter.typ": mainmatter
#import "layouts/appendix.typ": appendix

#import "pages/fonts-display-page.typ": fonts-display-page
#import "pages/bachelor-cover.typ": bachelor-cover
#import "pages/bachelor-abstract.typ": bachelor-abstract
#import "pages/bachelor-abstract-en.typ": bachelor-abstract-en
#import "pages/bachelor-outline-page.typ": bachelor-outline-page
#import "pages/acknowledgement.typ": acknowledgement

#import "utils/custom-cuti.typ": *
#import "@preview/i-figured:0.2.4": show-figure, show-equation
#import "utils/bilingual-bibliography.typ": bilingual-bibliography
#import "utils/custom-numbering.typ": custom-numbering
#import "utils/custom-heading.typ": heading-display, active-heading, current-heading
#import "utils/indent.typ": indent, fake-par
#import "utils/style.typ": 字体, 字号

// 使用函数闭包特性，通过 `documentclass` 函数类进行全局信息配置，然后暴露出拥有了全局配置的、具体的 `layouts` 和 `templates` 内部函数。
#let documentclass(
  // 文档类型，默认为本科生 bachelor
  doctype: "bachelor",

  // 学位类型，默认为学术型 acedemic
  degree: "academic",

  // 显示页眉
  display-header: true,

  // 双面模式，会加入空白页，便于打印
  twoside: true,

  // 盲审模式
  anonymous: false,

  // 参考文献函数
  bibliography: none,

  // 字体，应传入「宋体」、「黑体」、「楷体」、「仿宋」、「等宽」
  fonts: (:),
  info: (:),
) = {
  // 1.  默认参数
  fonts = 字体 + fonts
  info = (
    title: ("本科毕业设计（论文）题目", "此行若无内容，横线保留"),
    department: "通信与控制工程",
    major: "自动化",
    student-id: "34567890",
    author: "梁溪媛",
    supervisor: ("常广溪", "教授"),
    supervisor-ii: (),
    submit-date: datetime.today(),
  ) + info

  // 2.  预处理
  // 2.1 如果是字符串，则使用换行符将标题分隔为列表
  if type(info.title) == str {
    info.title = info.title.split("\n")
  }

  (
    // 将传入参数再导出
    doctype: doctype,
    degree: degree,
    display-header: display-header,
    twoside: twoside,
    anonymous: anonymous,
    bibliography: bibliography,
    fonts: fonts,
    info: info,

    // 页面布局
    doc: (..args) => {
      doc(
        ..args,
        info: info + args.named().at("info", default: (:)),
      )
    },

    // 前言
    preface: (..args) => {
      preface(
        twoside: twoside,
        ..args,
        fonts: fonts + args.named().at("fonts", default: (:)),
      )
    },

    // 正文
    mainmatter: (..args) => {
      if doctype == "bachelor" {
        mainmatter(
          twoside: twoside,
          ..args,
          fonts: fonts + args.named().at("fonts", default: (:)),
        )
      }
    },

    // 正文结束
    mainmatter-end: (..args) => {
      mainmatter-end(
        ..args,
      )
    },

    // 附录
    appendix: (..args) => {
      appendix(
        ..args,
      )
    },

    // 字体展示页
    fonts-display-page: (..args) => {
      fonts-display-page(
        twoside: twoside,
        ..args,
        fonts: fonts + args.named().at("fonts", default: (:)),
      )
    },

    // 封面页，通过 type 分发到不同函数
    cover: (..args) => {
      if doctype == "bachelor" {
        bachelor-cover(
          anonymous: anonymous,
          twoside: twoside,
          ..args,
          fonts: fonts + args.named().at("fonts", default: (:)),
          info: info + args.named().at("info", default: (:)),
        )
      }
    },

    // 中文摘要页，通过 type 分发到不同函数
    abstract: (..args) => {
      if doctype == "bachelor" {
        bachelor-abstract(
          display-header: display-header,
          twoside: twoside,
          ..args,
          fonts: fonts + args.named().at("fonts", default: (:)),
        )
      }
    },

    // 英文摘要页，通过 type 分发到不同函数
    abstract-en: (..args) => {
      if doctype == "bachelor" {
        bachelor-abstract-en(
          display-header: display-header,
          twoside: twoside,
          ..args,
          fonts: fonts + args.named().at("fonts", default: (:)),
        )
      }
    },

    // 目录页
    outline-page: (..args) => {
      bachelor-outline-page(
        display-header: display-header,
        twoside: twoside,
        ..args,
        fonts: fonts + args.named().at("fonts", default: (:)),
      )
    },

    // 参考文献页
    bilingual-bibliography: (..args) => {
      bilingual-bibliography(
        bibliography: bibliography,
        ..args,
      )
    },

    // 致谢页
    acknowledgement: (..args) => {
      acknowledgement(
        anonymous: anonymous,
        twoside: twoside,
        ..args,
      )
    },
  )
}
