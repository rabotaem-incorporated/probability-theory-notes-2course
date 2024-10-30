#import "../config.typ"
#import "@preview/cetz:0.3.1"
#import "@preview/cetz-plot:0.1.0"
#import "@preview/finite:0.3.2": automaton

#let chapter_state = state("chapter", "")

#let clabel(name) = {
  [
    $zws$#label(name)
  ]
}

#let notes(
  name: none,
  short-name: none,
  lector: none,
  info: none,
  document_body,
) = {
  set document(author: "Rabotaem Inc.", title: name)
  set page(
    paper: "a4",
    margin: 6%,
    numbering: "1",
    number-align: right + top,
    header: [
      #context {
        let it = chapter_state.get()
        if it != "" {
          stack(
            spacing: .5em,
            [
              #it
            ],
            line(length: 100%),
          )
        }
      }
    ],
    header-ascent: 2em,
    footer: [
      #context {
        let it = counter(page).get().first()
        if it != 1 {
          stack(
            spacing: .5em,
            line(length: 100%),
            [
              @start[#short-name]
              #h(1fr)
              #it   
            ]
          )
        }
      }
    ]
  )

  show outline.entry.where(
    level: 1
  ): it => {
    v(12pt, weak: true)
    strong(it)
  }
  
  set text(
    lang: "ru",
    region: "ru",
    size: 12pt,
  )

  set heading(
    numbering:  (..nums) => {
      let res = ""
      let skip = nums.pos().len() > 1
      for i in nums.pos() {
        if skip {
          skip = false
        } else {
          res += str(i) + "."
        }
      }
      return res 
    },
  )
  
  set enum(
    numbering: "1.a)",
  )

  set math.equation(numbering: (..nums) => "")

  show heading.where(level: 1): it => {
    chapter_state.update(it.body.text)
    [
      #pagebreak(weak: true) 
      #it
    ]
  }

  show heading.where(level: 2): it => {
    chapter_state.update(it.body.text)
    it
  }

  show "≥": "⩾"
  show "≤": "⩽"

  [
    #clabel("start")
    #align(center + horizon)[
      #text(
         size: 30pt
      )[
        *#name*
      ]
      #if lector != none {
        v(
          5%,
          weak: true,
        )
        text(
          size: 20pt,
        )[
          Лектор: #lector
        ]
      }
    ]
    #align(center + bottom)[
      #text(
        size: 18pt,
        style: "italic",
        weight: 500
      )[
        #info
      ]
    ]

    //#set par(justify: true)
    #outline(indent: true)
    #document_body
  ]
}

#let last_theorem = state("last_theorem", none)

#let make_theorem(th_type, th_type_plural: none, color: white, highlight_color: none, glues_to: ()) = {
  if highlight_color == none {
    highlight_color = color.lighten(25%)
  }

  let typ-label = label
  (name: none, label: none, plural: false, content, glue: false) => {
    context {
      let lt = last_theorem.at(here())
      // [Value: #lt]
      let th_label = query(selector(<end-of-last-th>).before(here()))
      let last_th_page = if th_label.len() > 0 { 
        th_label.last().location().page()
      } else { 
        -1
      }

      if (glue or lt in glues_to) and last_th_page == here().page() { 
        if not config.monochrome {
          v(-0.4em)
        } else {
          v(-0.4em + 1pt)
        }
      }
    }

    last_theorem.update(th_type)

    let th_type = th_type
    if plural and th_type_plural != none {
      th_type = th_type_plural
    }

    let th_content = {
      if label != none and config.debug {
        place(
          top + left, dx: -0.2cm, dy: -0.25cm,
          text(highlight_color.darken(20%), size: 0.7em, raw(label))
        )
      }
      if name != none [
        #let name_string = if type(name) == "string" { 
          name 
        } else if "text" in name.fields() {
          name.text
        } else {
          ""
        }

        #if name_string.starts-with(regex("(об |о |О |Об )")) [
          #let name_string = name_string.replace("О ", "о ").replace("Об ", "об ")
          *#th_type #name_string.*  
        ] else [
          *#th_type (#name).* 
        ]
      ] else [
        *#th_type.*
      ]
      
      [#sym.space.hair #box()<end-of-last-th> #content]
    }

    let th_block = block.with(
      outset: .4em,
      inset: .4em,
      width: 100%,
      fill: if not config.monochrome { color.lighten(90%) } else { none }, 
      stroke: if not config.monochrome {
        (left: highlight_color, )
      } else {
        (
          left: highlight_color + 2pt,
          right: highlight_color + 1pt,
          top: highlight_color + 1pt,
          bottom: highlight_color + 1pt,
        )
      },
    )

    if label != none {
      [
        #{
          metadata(highlight_color)
          th_block(th_content)
        }
        #typ-label("_THEOREM_" + label)
      ]
    } else {
      th_block(th_content)
    }
  }
}

#let sublabel(lbl) = {
  if config.debug {
    place(text(red, size: 0.6em, raw(lbl)))
  }
  [#[]#label("_THEOREM_SUBLABEL_" + lbl)]
}

#let show-references(content) = {
  show metadata: it => {
    if not config.references { return it }
    if type(it.value) != dictionary { return it }
    if "id" not in it.value { return it }
    if it.value.id != "rf" { return it }
    let args = it.value.args
    return super(context {
      let lbl = args.pos().at(0)
      let sublabel = args.pos().at(1, default: none)
      let lbl = label("_THEOREM_" + lbl)
      let label-instance = query(lbl)
      if label-instance.len() != 1 {
        if config.strict-refs {
          panic("Label " + str(lbl) + " have been seen " + str(label-instance.len()) + " times")
        } else {
          return none
        }
      }
      label-instance = label-instance.first()
      let color = label-instance.children.first().value
      if sublabel != none {
        let sublabels = query(
          selector(label("_THEOREM_SUBLABEL_" + sublabel))
            .after(label-instance.location())
        )
        if sublabels.len() != 0 {
          sublabel = sublabels.first()
          link(
            sublabel.location(),
            box(circle(radius: 2pt, stroke: none, fill: color))
          )
        } else {
          panic("couldn't find sublabel " + str(lbl) + ":" + str(sublabel))
        }
      } else {
        link(
          lbl,
          box(circle(radius: 2pt, stroke: none, fill: color))
        )
      }
    })
  }
  content
}

#let rf(..args) = metadata((id: "rf", args: args))

#let TODO(content) = rect(
  stroke: red + 2pt,
  fill: red.lighten(90%),
  width: 100%, inset: 0.2cm,
)[
  #text(weight: "extrabold")[TODO: ]
  #sym.space.hair 
  #if content != [] { content } else [ Дописать ]<todo-like>
]

#let th_color = if not config.monochrome { red } else { luma(20%) }
#let oth_color = if not config.monochrome { blue } else { luma(30%) }
#let def_color = if not config.monochrome { orange } else { luma(40%) }
#let proof_color = if not config.monochrome { gray } else { luma(80%) }

#let th = make_theorem("Теорема", color: th_color)
#let lemma = make_theorem("Лемма", color: th_color)
#let pr = make_theorem("Предложение", color: oth_color)
#let follow = make_theorem(
  "Следствие", color: oth_color,
  th_type_plural: "Следствия",
  glues_to: ("Теорема", "Лемма", "Доказательство")
)
#let def = make_theorem("Определение", color: def_color)
#let prop = make_theorem("Свойство", th_type_plural: "Свойства", color: oth_color)
#let props = prop.with(plural: true)
#let notice = make_theorem("Замечание", highlight_color: proof_color,
  th_type_plural: "Замечания")
#let remind = make_theorem("Напоминание", highlight_color: proof_color)
#let example = make_theorem("Пример", th_type_plural: "Примеры", 
    highlight_color: def_color.lighten(25%), glues_to: (
    "Теорема", "Лемма", "Предложение", "Следствие", 
    "Свойство", "Свойства", "Замечание", "Определение",
    "Доказательство", "Обозначение",
))
#let examples = example.with(plural: true)
#let exercise = make_theorem("Упражнение", highlight_color: proof_color)
#let denote = make_theorem("Обозначение", color: def_color)

#let proof = make_theorem("Доказательство", highlight_color: proof_color, 
  glues_to: (
    "Теорема", "Лемма", "Предложение", "Следствие", 
    "Свойство", "Свойства", "Замечание"
  )
)

#import "shortcuts.typ": *

#let ticket(name, step-fn: none, post-step-fn: none) = if config.enable-ticket-references {
  let ticket-counter = counter("ticket")

  let width = 0.7cm
  let offset = 0.5cm
  let color = if not config.monochrome { purple.lighten(60%) } else { gray }

  if step-fn != none {
    ticket-counter.update(step-fn)
  } else {
    ticket-counter.step()
  }
  
  block(above: 0.2cm, below: 0.2cm, 
    rect(stroke: none, width: 100%, par[
      #align(end, text(size: 0.75em, fill: color.darken(30%))[
        Билет #context ticket-counter.get().first();.
        #name
      ])

      #v(-0.9em)

      #line(length: 100% + width + offset, stroke: (
        paint: color,
        dash: "dashed"
      ))
      
      #place(dy: -1cm)[#hide(name)<ticket>]

      #let tag = place(
        dx: offset,
        end,
      )[
        #place(polygon(
          fill: color.lighten(70%),
          stroke: color + 1pt,
          (0pt, 0pt),
          (0pt, width),
          (width * 0.5, width * 1.5),
          (width, width),
          (width, 0pt),
        ))

        #place(dy: width * 0.15, block.with(width: width)(
          align(text(fill: color.darken(30%), weight: "bold")[
            #text(size: 1.5em, context ticket-counter.get().first())
            #move(dy: -1.6em, text(size: 0.5em)[билет])
          ], center)
        ))
      ]

      #context {
        let target = query(<ticket-reference>)
        if target.len() == 0 {
          tag
        } else {
          link(<ticket-reference>, tag)
        }
      }
    ]
  ))

  if post-step-fn != none {
    ticket-counter.update(post-step-fn)
  }
}

#let subgraph(label: [], domain: (), size: (10, 5), samples: 400, func) = align(center, cetz.canvas({
    import cetz.draw: *
    import cetz-plot: *

    plot.plot(name: "plot", axis-style: "school-book", size: size, x-tick-step: 1, y-tick-step: 0.1, {
      plot.add-fill-between(domain: domain, samples: samples, func, (x) => 0)
    })
    content(((0,-1), "-|", "plot.south"), label)
}))
