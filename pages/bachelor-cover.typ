#import "../utils/style.typ": 字号, 字体
#import "@preview/a2c-nums:0.0.1": int-to-cn-simple-num

// 本科生封面
#let bachelor-cover(
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
  let info-key(key) = {
    text(
      font: fonts.at(info-key-font),
      ..if(key == "title") {
        (weight: bold-level, size: 字号.二号)
      } else {
        (weight: "regular", size: 字号.小二)
      },
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
          let len = 0
          for i in info.title {
            len = calc.max(len, i.len())
          }
          h(1em * (15 - len / 3) / 2)
        } else if key in ("student-id", "author", "supervisor", "supervisor-ii") {
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
  // 边距
  set page(margin: if (twoside) {
    (top: 1.65cm, bottom: 2cm, inside: 3.17cm + 0.5cm, outside: 3.17cm)
  } else {
    (top: 1.65cm, bottom: 2cm, x: 3.17cm)
  })

  // 居中对齐
  set align(center)

  h(10em)
  h(4pt * 2 * 10)
  text(size: 字号.小四, font: fonts.宋体, weight: bold-level, spacing: 4pt * 2)[编 号]
  v(字号.一号 * 1.5)
  // 校名
  image("../assets/vi/jnu-name.png")
  v(字号.一号 * 1.5)

  text(
    size: 32pt,
    font: fonts.宋体,
    spacing: 2.5pt * 1.9,
    weight: bold-level,
  )[本 科 生 毕 业 设 计 （ 论 文 ）]

  v(字号.一号 * 1.5)

  set grid(row-gutter: 字号.二号 * 1.3)
  grid(
      columns: (6em, 1fr, 1fr, 1fr),
      info-key("title"),
      ..info.title.map((s) => info-long-value("title", s)).intersperse(info-key("blank")),
  )


  v(字号.一号 * 2)

  set grid(row-gutter: 字号.小二 * 1.3)
  block(width: 90%, grid(
    columns: (1.8fr, 4em, 1fr, 4em),
    info-short-value("department", info.department),
    info-key("department"),
    info-short-value("major", info.major),
    info-key("major"),
  ))

  v(字号.一号 * 2)

  block(
    width: 73%,
    grid(
      columns: (8em, 1fr, 1fr, 1fr),
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