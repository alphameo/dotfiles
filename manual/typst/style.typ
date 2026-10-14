#let fontsize = 14pt
#let rawFontsize = 13pt
#let tableFontsize = 12pt
#let tableRawFontsize = 11pt
#let font = "Times New Roman"
#let rawFont = "Courier New"
#let lineheightNorm = 0.65em
#let lineheightTight = 0.4em
#let lineheight = 1.5em - lineheightNorm
#let indent = 1.25cm
#let margin = (left: 3.0cm, right: 1.5cm, top: 2cm, bottom: 2cm)

#let struct_heading(body) = {
  upper(
    align(
      center,
      heading(body, numbering: none),
    ),
  )
}

#let heading_unnumbered(leveled_heading) = {
  set heading(numbering: none)
  pad(leveled_heading, left: indent)
}

#let organization(body) = {
  let placeLineheight = 1em - lineheightNorm
  set par(spacing: placeLineheight, leading: placeLineheight)
  align(
    center,
    upper(body),
  )
}

#let srcList(body) = {
  set enum(numbering: "1.", indent: indent, body-indent: 0.25cm)
  body
}

#let person(role: "", status: "", name: "") = {
  (role: role, status: status, name: name)
}

#let signatures(persons: (role: "", status: "", name: ""), len: auto) = {
  let signatureField = repeat("_", justify: false)
  let memb = ()

  for sig in persons {
    memb.push(sig.at("role"))
    memb.push(signatureField)
    memb.push([#sig.at("status") #sig.at("name")])
  }

  table(
    stroke: none,
    inset: 10pt,
    columns: (auto, len, auto),
    fill: none,
    ..memb
  )
}

#let setup(body) = {
  set page(
    paper: "a4",
    margin: margin,
  )

  set text(
    font: font,
    size: fontsize,
    lang: "ru",
    hyphenate: false,
  )

  show raw: set text(
    font: rawFont,
    size: rawFontsize,
    lang: "en",
  )

  set par(
    justify: true,
    first-line-indent: (amount: indent, all: true),
    leading: lineheight,
    spacing: lineheight,
  )

  set heading(numbering: "1.1")
  show heading: it => {
    text(
      block(
        it,
        above: lineheight,
        below: lineheight,
      ),
      size: fontsize,
    )
  }
  show heading.where(numbering: "1.1"): it => {
    pad(it, left: indent)
  }

  set outline(title: none, indent: 1cm)
  show outline: it => {
    align(center, upper(text("Содержание", weight: "bold")))
    linebreak()
    it
  }

  set list(marker: [--], indent: indent, body-indent: 0.5em)
  set enum(numbering: "1)", indent: indent, body-indent: 0.25cm)

  set table(
    align: left,
    fill: (col, row) => if row == 0 {
      rgb("e0e0e0")
    } else { none },
  )

  show table: it => {
    set par(leading: lineheightTight, justify: false)
    set text(size: tableFontsize)
    show raw: set text(size: tableRawFontsize)
    it
  }

  show figure.where(kind: image): set figure(supplement: [Рисунок])

  show figure.where(kind: raw): it => {
    set figure.caption(position: top)
    align(left, it)
  }

  set figure.caption(separator: [ -- ])

  show figure: set block(breakable: true)

  show ref.where(form: "normal"): set ref(supplement: it => {
    if it.func() == figure {
      none
    }
  })

  set bibliography(
    title: none,
    style: "gost-r-705-2008-numeric",
  )
  show bibliography: it => {
    struct_heading("Список использованных источников")
    linebreak()
    it
  }

  body
}
