#import "../utils/style.typ": 字号, 字体

// 本科生封面
#let bachelor-cover(
  // documentclass 传入的参数
  anonymous: false,
  twoside: true,
  fonts: (:),
  info: (:),
  // 其他参数
  stoke-width: 1pt,
  min-title-lines: 2,
  info-inset: (x: 0pt, y: -1pt),
  info-key-font: "宋体",
  info-value-font: "黑体",
  row-gutter: 24pt,
  anonymous-info-value: ("grade", "student-id", "author", "supervisor", "supervisor-ii"),
  bold-level: 600,
) = {
  // 1.  默认参数
  fonts = 字体 + fonts

  let center-info-value = ("department", "major")

  let key2body = (
    title: "题目：",
    department: "学 院",
    major: "专 业",
    student-id: "学　　号",
    author: "学生姓名",
    supervisor: "指导教师",
    supervisor-ii: "",
    blank: "　",
  )

  // 2.  对参数进行处理
  // 2.1 根据 min-title-lines 填充标题
  info.title = info.title + range(min-title-lines - info.title.len()).map((it) => "　")

  // 2.2 二字姓名处理
  let tmp = info.author
  if (tmp.len() == 6) {
    info.author = tmp.first() + "　" + tmp.last()
  }
  let tmp = info.supervisor.at(0)
  if (tmp.len() == 6) {
    info.supervisor.at(0) = tmp.first() + "　" + tmp.last()
  }
  if info.supervisor-ii != (){
    let tmp = info.supervisor-ii.at(0)
    if (tmp.len() == 6) {
      info.supervisor-ii.at(0) = tmp.first() + "　" + tmp.last()
    }
  }

  // 3.  内置辅助函数
  let info-key(key) = {
    text(
      font: fonts.at(info-key-font),
      weight: if (key == "title") { bold-level } else { "regular" },
      size: if (key == "title") { 字号.二号 } else { 字号.小二 },
      key2body.at(key),
    )
  }

  let info-value(key, body) = {
    align(
      if (key in center-info-value) { center } else { left },
      rect(width: 100%, stroke: (bottom: stoke-width + black), text(
        font: fonts.at(info-value-font),
        size: if (key == "title") { 字号.二号 } else { 字号.小二 },
        bottom-edge: "descender",
        if key not in center-info-value {
          if key == "title" {
            let tmp = int((16 - info.title.at(0).len() / 3) / 2)
            "　" * tmp
          } else {
            "　" * 3
          }
        } + body,
      )),
    )
  }

  let info-long-value(key, body) = {
    grid.cell(
      colspan: 3,
      info-value(key, if anonymous and (key in anonymous-info-value) {
        "██████████"
      } else {
        body
      }),
    )
  }

  let info-short-value(key, body) = {
    info-value(key, if anonymous and (key in anonymous-info-value) {
      "█████"
    } else {
      body
    })
  }

  // 4.  正式渲染
  pagebreak(weak: true, to: if twoside { "odd" })
  set rect(inset: info-inset)

  // 居中对齐
  set align(center)

  // 匿名化处理去掉封面标识
  if anonymous {
    v(88pt)
  } else {
    h(18em)
    text(size: 字号.小四, font: fonts.宋体, weight: bold-level)[编 号]
    v(42pt)
    // 校名
    image("../assets/vi/jnu-name.png")
    v(42pt)
  }

  text(
    size: 32pt,
    font: fonts.宋体,
    spacing: 7.5pt,
    weight: bold-level,
  )[本 科 生 毕 业 设 计 （ 论 文 ）]

  if anonymous {
    v(155pt)
  } else {
    v(42pt)
  }

  set grid(row-gutter: row-gutter)

  block(width: 92%,grid(
      columns: (70pt, 1fr, 1fr, 1fr),
      info-key("title"),
      ..info.title.map((s) => info-long-value("title", s)).intersperse(info-key("blank")),
    ),
  )

  v(42pt)

  block(width: 90%, grid(
    columns: (2fr, 48pt, 1fr, 48pt),
    info-short-value("department", info.department),
    info-key("department"),
    info-short-value("major", info.major),
    info-key("major"),
  ))

  v(42pt)

  block(
    width: 60%,
    grid(
      columns: (90pt, 1fr, 1fr, 1fr),
      info-key("student-id"),
      info-long-value("student-id", info.student-id),
      info-key("author"),
      info-long-value("author", info.author),
      info-key("supervisor"),
      info-long-value("supervisor", info.supervisor.at(0) + "  " + info.supervisor.at(1)),
      info-key("supervisor-ii"), 
      (if info.supervisor-ii != () {
        info-long-value("supervisor-ii", info.supervisor-ii.at(0) + "  " + info.supervisor-ii.at(1))
      } else {
        info-long-value("supervisor-ii","")
      }),
    ),
  )

  v(42pt)

  set text(size: 字号.小二)
  text(font: fonts.黑体)[二〇]
  text(font: fonts.宋体)[　　年　月]
}