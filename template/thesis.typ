#import "../lib.typ": documentclass, indent, show-cn-fakebold

// 你首先应该安装 fonts/FangZheng 里的所有字体，
// 如果是 Web App 上编辑，你应该手动上传这些字体文件，否则不能正常使用「楷体」和「仿宋」，导致显示错误。

#let (
  // 布局函数
  twoside, doc, preface, mainmatter, mainmatter-end, appendix,
  // 页面函数
  fonts-display-page, cover, abstract, abstract-en, outline-page, bilingual-bibliography, acknowledgement,
) = documentclass(
  // 文档类型，默认为本科生 bachelor
  doctype: "bachelor",

  // 双面模式，会加入空白页，便于打印，
  // 江南大学本科毕业设计要求双面打印，此文档为了方便浏览将其设为 false
  twoside: false,

  // 可自定义字体，先英文字体后中文字体，应传入「宋体」、「黑体」、「楷体」、「仿宋」、「等宽」
  // 所有字体的 fallback 顺序可以在`utils\style.typ`中修改
  // 江南大学毕业论文模板中规定所有字母与数字的字体为 Times New Roman，
  // 全文的汉字字体为宋体
  fonts: (宋体: ("Times New Roman", "SimSun"), 黑体:("SimHei")),

  info: (
    title: ("本科毕业设计（论文）题目", "此行若无内容，横线保留"),
    department: "通信与控制工程",
    major: "自动化",
    student-id: "34567890",
    author: "梁溪媛",
    supervisor: ("常广溪", "教授"),
    supervisor-ii: ("江南", "讲师"),
    submit-date: datetime.today(),
  ),
  // 参考文献源
  bibliography: bibliography.with("ref.bib"),
)

// 文稿设置
#show: doc
// 由于 SimSun 字体没有字重，需要使用使用伪粗体显示加粗
// 如果你的中文字体包含了字重，可以将下面这行注释掉
#show: show-cn-fakebold

// 字体展示测试页
// #fonts-display-page()

// 封面页
#cover()

// 前言
#show: preface

// 中文摘要
#abstract(keywords: ("毕业论文", "模板", "规范", "图", "表"))[
  论文摘要以浓缩的形式概括研究课题的内容，中文摘要在400字左右，外文摘要与中文内容相同，关键词一般以3～5个为妥，词与词之间以“；”为分隔。

  设计总说明主要介绍设计任务来源、设计标准、设计原则及主要技术资料，中文字数要在1000～2000字以内，外文字数以500～1000个左右为宜，关键词一般以3～5个为妥，词与词之间以“；”分隔。
]

// 英文摘要
#abstract-en(keywords: ("Thesis", "template", "criterion", "figure", "table"))[
  It is the English translation of the Chinese abstract. Font: Times New Roman,
  Word Size: 12. (same as “小四”).
]

// 目录
#outline-page()

// 正文
#show: mainmatter

= Typst 模板使用说明
== 列表

=== 无序列表

- 无序列表项一
- 无序列表项二
  - 无序子列表项一
  - 无序子列表项二

=== 有序列表

+ 有序列表项一
+ 有序列表项二
  + 有序子列表项一
  + 有序子列表项二

=== 术语列表

/ 术语一: 术语解释
/ 术语二: 术语解释

== 图表
引用@tbl:timing-tlt，以及@fig:jnu-logo。引用图表时，表格和图片分别需要加上 `tbl:`和`fig:` 前缀才能正常显示编号。

#figure(
  table(
    columns: 4,
    stroke: none,
    table.hline(),
    [t],
    [1],
    [2],
    [3],
    table.hline(stroke: .5pt),
    [y],
    [0.3s],
    [0.4s],
    [0.8s],
    table.hline(),
  ),
  caption: [三线表],
) <timing-tlt>


#v(1em)

#figure(image("..\assets\vi\jnu-name.png", width: 40%), caption: [图片测试]) <jnu-logo>

== 数学公式

可以像 Markdown 一样写行内公式 $x + y$，以及带编号的行间公式：

$ phi.alt := (1 + sqrt(5)) / 2 $ <ratio>

引用数学公式需要加上 `eqt:` 前缀，则由@eqt:ratio，我们有：

$ F_n = floor(1 / sqrt(5) phi.alt^n) $

我们也可以通过 `<->` 标签来标识该行间公式不需要编号

$ y = integral_1^2 x^2 dif x $ <->

而后续数学公式仍然能正常编号。

$ F_n = floor(1 / sqrt(5) phi.alt^n) $

== 参考文献
可以像这样引用参考文献：图书#[@于潇2012]和会议#[@伍言真1998]。

== 代码块

代码块支持语法高亮。引用时需要加上 `lst:` @lst:code

#figure(
  ```py
  def add(x, y):
    return x + y
  ```,
  caption: [代码块],
) <code>

注意：以下章节内容为江南大学本科论文要求。

= 绪论
正文的每一章章节题目为从奇数页面第一行起始。

绪论应说明本课题的意义、目的、研究范围及要达到的技术要求；简述本课题在国内外的发展概况及存在的问题；说明本课题的指导思想；阐述本课题应解决的主要问题。

== 二级标题
二级标题四号加粗，顶格，空一格写标题内容全文（包括所有的章节题目）的汉字字体为宋体，章节序号、所有字母与数字的字体为Times New Roman。

=== 三级标题
三级标题小四号加粗，顶格，空一格写标题内容。

= 字体字号与页面设置
== 字体字号
全文（包括所有的章节题目）的汉字字体为宋体，章节序号、所有字母与数字的字体为Times New
Roman。一级标题（指中英文摘要标题、各章标题、致谢、参考文献及附录标题）字号为三号加粗；二级标题四号加粗；三级标题小四号加粗。

=== 科学技术
科学技术名词术语尽量采用全国自然科学名词审定委员会公布的规范词或国家标准、部标准中规定的名称，尚未统一规定或叫法有争议的名称术语，可采用惯用的名称。使用外文缩写代替某一名词术语时，首次出现时应在括号内注明其含义。

== 页面设置
A4幅面，双面印刷；

行距：1.25倍；

页码：居中；

边距：上下左右各空2cm，装订线位于左侧，0.5cm；

页眉：奇数页为毕业（设计）论文的题目，偶数页为“江南大学学士学位论文”，宋体小五号；

正文的每一章章节题目为从奇数页面第一行起始。

= 图与公式的格式要求
== 图
=== 图及图题标注范例
Buck变换器是单管不隔离型DC-DC变换器中的一种基本结构#[@于潇2012]，其基本电路如@fig:example-fig 所示。

#figure(
  image("images/example-figure.png", width: 50%),
  caption: [图题字体宋体，字号为五号],
) <example-fig>

#v(1em)

=== 公式及其标注范例
为了使负载电流连续且脉动小，通常串接L值较大的电感，即使电路工作在CCM模式下，当电路工作于稳态时，负载电压的平均值为：

$ U_o = t_"on" / (t_"on" + t_"off") E = t_"on" / T E = u E. $ <physics>

@eqt:physics 说明了XX之间的关系。

= 表的格式要求
== 表的格式
=== 表范例
数据如@tbl:example-tbl 所示，表内容字号五号，字体要求与正文同。

#v(1em)

#figure(
  table(
    columns: 4,
    stroke: none,
    column-gutter: 2em,
    row-gutter: 2pt,
    table.hline(),
    [参数],
    [数值],
    [参数],
    [数值],
    table.hline(stroke: 0.5pt),
    [R],
    [4$ohm$],
    [L],
    [20mH],
    [E],
    [12V],
    [C],
    [0.5mF],
    [f],
    [300Hz],
    [u],
    [0.5],
    table.hline(),
  ),
  caption: [表题字体宋体，字号五号],
) <example-tbl>

#v(2em)

== 表的内容
表的内容字号为五号，字体要求与正文同。

= 结论与展望
== 结论
XXX

== 不足之处及未来展望
XXX

// 手动分页
#if twoside {
  pagebreak() + " "
}

// 中英双语参考文献
// 默认使用 gb-7714-2015-numeric 样式
#bilingual-bibliography(full: true)

// 致谢
#acknowledgement[
  致谢应以简短的文字对在课题研究和设计说明书（论文）撰写过程中曾直接给予帮助的人员或单位表示自己的谢意，这不仅是一种礼貌，也是对他人劳动的尊重，是治学者应有的思想作风，比如：本文是在导师XXX教授和XXX讲师的悉心指导下完成的，表示谢意！

  感谢XX。

  感谢 Mordern NJUThesis Typst 模板。
]

// 手动分页
#if twoside {
  pagebreak() + " "
}


// 附录
#show: appendix

= 附录A： 作者在校期间发表的论文
// Typst 不支持加载两个bib，因此你只能在这里手打自己的成果
[1]作者．文献题名[J]．刊名，出版年份，卷号(期号) ：起止页码．

= 附录B： XX
附录是对于一些不宜放在正文中，但有参考价值的内容，可编入毕业设计（论文）的附录中，例如公式的推演、编写的程序等；当文章中引用的符号较多时，便于读者查阅，可以编写一个符号说明，注明符号代表的意义，也可作为附录的内容。一般附录放在全文最后。

// 正文结束标志，不可缺少
// 这里放在附录后面，使得页码能正确计数
#mainmatter-end()