#import "../utils/style.typ": 字号, 字体
#import "@preview/a2c-nums:0.0.1": int-to-cn-simple-num

// 课程设计封面
#let coursework-cover(
  // documentclass 传入的参数
  twoside: true,
  fonts: (:),
  info: (:),
  // 其他参数
  stoke-width: 1pt,
  min-title-lines: 2,
  info-inset: (x: 0pt, y: 0pt),
  info-key-font: "宋体",
  info-value-font: "黑体",
  bold-level: "bold",
) = {
  // 1.  默认参数
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

  for key in ("supervisor", "supervisor-ii"){
    if info.at(key) != (){
      let tmp = info.at(key).at(0)
      if(tmp.len() == 6) {
        info.at(key).at(0) = tmp.first() + "　" + tmp.last()
      }
    }
  }

  // 3.  内置辅助函数
  let blank-line = {
    grid.cell(colspan: 4, text(size:字号.小二,"　"))
  }

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
      if key in ("department", "major") { center } else { left },
      rect(width: 100%, stroke: (bottom: stoke-width + black), text(
        font: fonts.at(info-value-font),
        size: if (key == "title") { 字号.二号 } else { 字号.小二 },
        bottom-edge: "descender",
        if key == "title" {
          let len = (15 - info.title.at(0).len() / 3) / 2
          h(1em * len)
        }
        else if key in ("student-id", "author", "supervisor", "supervisor-ii") {
          h(3em)
        } + body
      )),
    )
  }

  let info-short-value(key, body) = {
    info-value(key, body)
  }

  let info-long-value(key, body) = {
    grid.cell(colspan: 3, info-value(key, body))
  }

  // 4.  正式渲染
  pagebreak(weak: true, to: if twoside { "odd" })
  set rect(inset: info-inset)
  set page(margin: if (twoside) {
    (top: 1.65cm, bottom: 2cm, x: 3.17cm, inside: 2.67cm)
  } else {
    (top: 1.65cm, bottom: 2cm, x: 3.17cm)
  })
  
  // 居中对齐
  set align(center)

  v(120pt)

  // 文档标题
  text(
    size: 32pt,
    font: fonts.宋体,
    spacing: 7.5pt,
    weight: bold-level,
    info.doc-title
  )

  v(120pt)

  set grid(row-gutter: 字号.二号 * 1.5)
  block(width: 97%, grid(
      columns: (6em, 1fr, 1fr, 1fr),
      info-key("title"),
      ..info.title.map((s) => info-long-value("title", s)).intersperse(info-key("blank")),
    ),
  )

  v(字号.一号 * 1.5)

  set grid(row-gutter: 字号.小二 * 1.5)
  block(width: 90%, grid(
    columns: (1.8fr, 4em, 1fr, 4em),
    info-short-value("department", info.department),
    info-key("department"),
    info-short-value("major", info.major),
    info-key("major"),
  ))

  v(字号.一号 * 1.5)

  block(
    width: 73%,
    grid(
      columns: (8em, 1fr, 1fr, 1fr),
      info-key("student-id"),
      info-long-value("student-id", info.student-id),
      info-key("author"),
      info-long-value("author", info.author),

      ..(for key in ("supervisor", "supervisor-ii") {
        if info.at(key) != (){(
          info-key(key),
          info-long-value(key, info.at(key).at(0) + "  " + info.at(key).at(1))
          )} else{(
            blank-line,
          )}
      })
    )
  )

  v(字号.三号 * 1.5 * 2)

  set text(size: 字号.小二)
  text(font: fonts.黑体, int-to-cn-simple-num(info.year))
  text(font: fonts.宋体)[ 年 ]
  text(font: fonts.黑体, int-to-cn-simple-num(info.month))
  text(font: fonts.宋体)[ 月]
}