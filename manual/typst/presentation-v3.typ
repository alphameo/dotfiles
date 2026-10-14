#import "@preview/polylux:0.4.0": *
#import "coursework.typ": *

#let fontsize = 24pt

#set page(
  paper: "presentation-16-9",
  margin: 1.5cm,
  number-align: right,
)
#set text(
  font: "Roboto",
  size: fontsize,
  lang: "ru",
  hyphenate: false,
)
#show raw: set text(font: "JetBrainsMono NFM", size: fontsize)
#set heading(numbering: "1.1")

#show figure.where(kind: image): set figure(supplement: none)

#let heading_unnumbered(body) = {
  set heading(numbering: none)
  body
}

#slide[
  #text(
    organization(org),
    size: 18pt,
  )

  #v(20pt)

  #text(
    align(center, faculty_n_cathedral),
    size: 18pt,
  )

  #v(10pt)

  #align(center, title)
  #align(right + bottom, block(align(left, text(
    [
      Обучающийся: #me.status #me.name

      Руководитель: #supervisor.status #supervisor.name
    ],
    size: 20pt,
  ))))
]

#set page(numbering: "1")

#slide[

  #heading_unnumbered[= Определения, обозначения и сокращения]

  #align(
    horizon + left,
    [#lorem(1) -- #lorem(40)],
  )
]

#slide[

  = Постановка задачи

  #align(horizon, [

    Цель работы -- #lorem(15).

    Функциональные возможности:

    - #lorem(5)
    - #lorem(6)
  ])
]

#slide[

  #align(horizon + center, [== Обзор аналогов])

]


#slide[

  = Анализ предметной области

  #align(horizon, [
    #lorem(100)
  ])

]


#slide[

  = Реализация

  == Средства реализации
  #align(horizon, [

    - #lorem(7)
    - #lorem(7)
    - #lorem(7)
    - #lorem(7)
    - #lorem(7)
  ])
]

#slide[

  == Логика приложения

  #align(horizon, [
    #figure(
      image("img/img.svg", width: 11em),
    )
  ])
]

#slide[

  == Реализация интерфейса

]


#slide[

  === Пользовательский интерфейс приложения
  #grid(
    columns: 2,
    gutter: 7em,
    figure(
      image("img/img.svg", height: 9em),
      caption: [#lorem(1)],
    ),
    figure(
      image("img/img.svg", height: 9em),
      caption: [#lorem(2)],
    ),
  )
]

#slide[

  #heading_unnumbered[=== Примеры интерфейса приложения]
]

#slide[

  #heading_unnumbered[= Заключение]
  #lorem(50)
]
