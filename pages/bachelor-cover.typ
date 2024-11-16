#import "../utils/style.typ": 字号
#import "@preview/a2c-nums:0.0.1": int-to-cn-num, int-to-cn-simple-num

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
  info-inset: 0pt,
  info-key-font: "宋体",
  info-value-font: "黑体",
  column-gutter: 0.5em,
  row-gutter: 1.3em,
  anonymous-info-keys: ("student-id", "author", "supervisor", "supervisor-ii"),
  bold-level: "bold",
) = {
  // 1.  默认参数
  let key-value = (
    title: "题目：",
    department: "学 院",
    major: "专 业",
    student-id: "学　　号",
    author: "学生姓名",
    supervisor: "指导教师",
    supervisor-ii: "",
  )
  let blank = "　"
  let mask = "█"

  // 2.  对参数进行处理
  // 2.1 根据 min-title-lines 填充标题
  info.title = info.title + range(min-title-lines - info.title.len()).map(it => blank)

  // 2.2 匿名化
  if anonymous {
    for info-key in info.keys() {
      if info-key in anonymous-info-keys {
        if type(info.at(info-key)) == str {
          if info-key == "student-id" {
            info.at(info-key) = mask * 5
          } else {
            info.at(info-key) = mask * 3
          }
        }

        if info-key in ("supervisor", "supervisor-ii") {
          info.at(info-key) = info.at(info-key).map(s => mask * 3)
        }
      }
    }
  } else {
    // 2.3 二字姓名处理
    if (info.author.clusters().len() == 2) {
      info.author = info.author.first() + blank + info.author.last()
    }

    for key in ("supervisor", "supervisor-ii") {
      if info.at(key).len() != 0 {
        let tmp = info.at(key).at(0)
        if (tmp.clusters().len() == 2) {
          info.at(key).at(0) = tmp.first() + blank + tmp.last()
        }
      }
    }
  }

  // 3.  内置辅助函数
  let info-key(key) = {
    text(
      font: fonts.at(info-key-font),
      key-value.at(key),
    )
  }

  let info-value(body) = {
    rect(
      inset: info-inset,
      stroke: (bottom: stoke-width),
      text(
        font: fonts.at(info-value-font),
        bottom-edge: "descender",
        body,
      ),
    )
  }

  // 4.  正式渲染
  set page(margin: if (twoside) {
    // 双页显示时，内侧需要留出 0.5cm 的装订线
    (top: 1.65cm, bottom: 2cm, inside: 3.17cm + 0.5cm, outside: 3.17cm)
  } else {
    (top: 1.65cm, bottom: 2cm, x: 3.17cm)
  })

  // 双页显示
  pagebreak(
    weak: true,
    to: if twoside {
      "odd"
    },
  )

  // 居中对齐
  set align(center)

  // 编号
  set text(size: 字号.小四)
  h(10 * (1em + 4pt * 1.9))
  text(font: fonts.宋体, weight: bold-level, spacing: 4pt * 1.9)[编 号]

  v(字号.一号 * 1.5)

  // 匿名化处理去掉校名
  if anonymous {
    v(60pt)
  } else {
    image("../assets/vi/jnu-name.png", height: 60pt)
  }

  v(字号.一号 * 1.5)

  set text(size: 32pt)
  text(
    font: fonts.宋体,
    spacing: 2.5pt * 1.9,
    weight: bold-level,
  )[本 科 生 毕 业 设 计 （ 论 文 ）]

  v(字号.一号 * 1.5)

  // 题目
  set text(size: 字号.二号)
  set rect(width: 100%)
  set grid(column-gutter: 0.5em, row-gutter: 1.3em)
  grid(
    columns: 2,
    text(font: fonts.宋体, weight: bold-level, key-value.at("title")),
    ..info.title.map(s => info-value(s)).intersperse(blank)
  )

  v(字号.一号 * 1.5)

  // 学院和专业
  set text(字号.小二)
  set rect(width: auto)
  set pad(x: 1.5em)
  grid(
    columns: 4,
    info-value(pad(info.department)), info-key("department"), info-value(pad(info.major)), info-key("major"),
  )

  v(字号.一号 * 1.5)

  // 其他信息
  set text(字号.小二)
  set rect(width: 100%)
  let info-value-left-align(body) = align(left, info-value(pad(left: 3em, body)))
  block(
    width: 73%,
    grid(
      columns: 2,
      info-key("student-id"), info-value-left-align(info.student-id),
      info-key("author"), info-value-left-align(info.author),
      info-key("supervisor"), info-value-left-align(info.supervisor.intersperse(blank).sum()),
      info-key("supervisor-ii"),
      if info.supervisor-ii.len() != 0 {
        info-value-left-align(info.supervisor-ii.intersperse(blank).sum())
      } else {
        info-value-left-align(blank)
      },
    ),
  )

  v(字号.三号 * 1.5 * 2)

  // 日期
  set text(size: 字号.小二)
  text(font: fonts.黑体, int-to-cn-simple-num(info.submit-date.year()))
  text(font: fonts.宋体)[ 年 ]
  text(font: fonts.黑体, int-to-cn-num(info.submit-date.month()))
  text(font: fonts.宋体)[ 月]
}