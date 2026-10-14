#import "style.typ": *
#show: setup.with()

//////////
// META //
//////////
#set document(
  author: "alphameo",
  title: "Title",
)

#let org = [
  Минобрнауки России

  Федеральное Государственное Бюджетное Образовательное
  \
  Учреждение Высшего Образования

  "Воронежский Государственный Университет"

  (ФГБОУ ВО "ВГУ")
]
#let faculty_n_cathedral = [
  Факультет компьютерных наук

  Кафедра программирования и информационных технологий
]

#let title = [Тема]

#let work_type = [Курсовая работа]

#let edu_year = [7 семестр 2026/2027 учебного года]

#let edu_program = [09.03.04 Программная инженерия]

#let study_field = [Информационные системы и сетевые технологии]

#let city_year = [Воронеж 2026]

#let cathedral = person(
  role: "Зав. кафедрой",
  status: "д.ф.-м.н., доцент",
  name: "И.О. Фамилия",
)
#let me = person(
  role: "Обучающийся",
  status: "ст. 4 курса",
  name: "И.О. Фамилия",
)
#let supervisor = person(
  role: "Руководитель",
  status: "д.ф.-м.н., доцент",
  name: "И.О. Фамилия",
)


////////////////
// TITLE PAGE //
////////////////

#organization(org)

#v(50pt)

#align(center, [
  #faculty_n_cathedral

  #v(80pt)

  #title

  #v(30pt)

  #work_type

  #edu_year

  #edu_program

  #study_field
])

#v(100pt)

#signatures(persons: (cathedral, me, supervisor), len: 135pt)

#align(bottom + center, city_year)

#pagebreak()

#set page(numbering: "1")

//////////
// BODY //
//////////

Нумерованный список:

+ Пункт 1.
+ Пункт 2.

Ненумерованный список:

- пункт 1;
- пункт 2;

\

Ссылка на таблицу @tbl
\
#figure(
  table(
    columns: (0.5fr, 1fr, 1fr),
    table.header([Понятие (класс)], [Описание], [Примеры экземпляров]),
    [`Patient`],
    [Пациент, прошедший обследование],
    [Пациент № 1 (63 года, мужчина)],

    [`Visit`], [Обследование пациента, центральное событие], [Обследование № 1],

  ),
  caption: [Таблица],
)<tbl>

Ссылка на рисунок @image.

\
#figure(
  image("img/img.svg", width: 19em),
  caption: [
    Изображение
  ],
) <image>
\

Ссылка на листинг @listing

#figure(
  caption: [Классы и иерархия],
  ```
  func source_code(input string) string {
    return fmt.Sprintf("src: %s", input)
  }
  ```,
)<listing>

Ссылка на источник @example-ref-name

#pagebreak()

#outline()

#pagebreak()

#struct_heading[Определения, обозначения и сокращения]
\
#pagebreak()

#struct_heading[Введение]
\
#pagebreak()

= Постановка задачи
\
== Обзор аналогов
\
#pagebreak()

= Анализ предметной области
#pagebreak()

= Реализация
\
== Средства реализации
\
== Логика приложения
\
== Реализация интерфейса
\
#pagebreak()

#struct_heading[Заключение]
\
#pagebreak()

#bibliography("references.yaml")
