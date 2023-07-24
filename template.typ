#import "common_symbols.typ": *
#import "manage.typ"
// The project function defines how your document looks.
// It takes your content and some metadata and formats it.
// Go ahead and custo// Go ahead and customize it to your liking!
#let cont_to_text(cont) = {
  if cont.has("text") {cont.text}
  else if cont.has("children") {cont.children.map(c => c.text).join("")}
}
#let labeled(label_cont) = {
  let text = cont_to_text(label_cont)
  [#[]#label(text)]
}

#let styling(body) = {
  set cite(style: "alphanumerical")
  set par(justify: true)
  set heading(numbering: "1.1 ")
  set text(font: "New Computer Modern", lang: "en")
  show math.equation: set text(weight: 400)
  show "TODO": t => text(red)[*#t*]
  body
}
#let sub_project(body, already:false) = {
  // set heading(numbering: "1.")
  // if not already {
  // set par(justify: true)
  // set heading(numbering: "1.")
  // set text(font: "New Computer Modern", lang: "en")
  // show math.equation: set text(weight: 400)
  // show "TODO": t => text(red)[*#t*]
  // bibliography("citations.yml")
  // }
  styling(body)
}
#let project(
  title: "",
  abstract: [],
  authors: (),
  type:"",
  department: "",
  institution: "",
  supervisors: (),
  date: none,
  body,
) = {
  // Set the document's basic properties.
  set page(numbering: "1", number-align: center)
  set document(author: authors.map(a => a.name), title: title)


  // Title row.
  align(center)[
    #block(text(weight: 700, 1.75em, title))
    #v(1em, weak: true)
    #date
  ]

  // Author information.
  pad(
    top: 0.5em,
    bottom: 0.5em,
    x: 2em,
    grid(
      columns: (1fr,) * calc.min(3, authors.len()),
      gutter: 1em,
      ..authors.map(author => align(center)[
        *#author.name* \
        #author.email
      ]),
    ),
  )
  linebreak()

  align(center,type)
  align(center,department + "\n" + institution)
  linebreak()

  if supervisors.len() > 0 {align(center)[Supervisor:]}
  grid(
    columns: (1fr,) * calc.min(3, authors.len()),
    gutter: 1em,
    ..supervisors.map(author => align(center)[
      *#author.name* \
      #author.email
    ]),
  )

  //abstract

  v(3em)
  set par(justify: true)
  heading(outlined: false, numbering: none, text(0.85em, smallcaps[Abstract]))
  abstract
  // Main body.

  // let sub_project = sub_project.with(already: true)
  styling[
    #body
  ]
  labeled[end_end]
}

// #let theorem_block(cont) = block(width:100%, stroke: luma(250), outset: 8pt, radius: 4pt,cont)
#let theorem_block(name, cont) = {
  // if name == "Example" or name == "RSmmary" [
  //   #block(
  //     width:100%, stroke: luma(240), outset: 8pt, radius: 4pt, spacing: 16pt,
  //    cont)
  // ] else [
  //   #block(width:100%)[#cont]
  // ]
  block(width:100%)[#cont]
}
// #let theorem_block(cont) = block(width:100%, stroke: luma(250), outset: 8pt, radius: 4pt,cont)


#let count_block_name = state("count_block_name")
#let count_block_loc = state("count_block_loc","HELLO")
#let countblock(name, conts, level: 3) = {
  count_block_name.update(name)
  counter(heading).step(level: level)
  if conts.len() == 1 [
    #block(width:100%)[
      *#name 
      #locate(loc => count_block_loc.update(loc))
      #counter(heading).display("1.")*
      #conts.at(0)
    ]
  ] else [
    #block(width:100%)[
      *#name 
      #locate(loc => count_block_loc.update(loc))
      #counter(heading).display("1.1")* (#conts.at(0)).
      #conts.at(1)
    ]
  ]
}

#let default_level = 3
#let definition(..conts, level: default_level) = countblock("Definition", conts.pos(), level: level)
#let theorem(..conts, level: default_level) = countblock("Theorem", conts.pos(), level: level)
#let example(..conts, level: default_level) = countblock("Example", conts.pos(), level: level)
#let lemma(..conts, level: default_level) = countblock("Lemma", conts.pos(), level: level)
#let corollary(..conts, level: default_level) = countblock("Corollary", conts.pos(), level: level)
#let remark(..conts, level: default_level) = countblock("Remark", conts.pos(), level: level)
#let summary(..conts, level: default_level) = countblock("Summary", conts.pos(), level: level)
#let notation(..conts, level: default_level) = countblock("Notation", conts.pos(), level: level)
 
#let proof(cont) = [#block[_Proof_. #cont #h(5pt)#h(1fr)$square.big$]]


#let cref(label_cont, fun:(label,location) => ref(label), allow_nonref:true) = {
  let my_label_text = cont_to_text(label_cont)
  let my_label = label(my_label_text)
  locate(loc => {
    let labels = query(my_label, loc)
    let count = labels.len()
    if count == 0 {
      if manage.is_main_document.at(loc) and not allow_nonref {
        ref(my_label) // gives error: label not found.
      }
      else {
        text(red)[*#my_label_text*]
      }
    }
    else {
      fun(my_label, labels.at(0).location())
    }
  })
}

#let tref(label_cont) = {
  cref(label_cont, fun:(label, location) => link(count_block_loc.at(location))[#count_block_name.at(location)~#numbering("1.1",..counter(heading).at(location))])
  }
#let ccite(cite_cont) = {
  let my_cite_text = cont_to_text(cite_cont)
  locate(loc => 
    if manage.is_main_document.at(loc) {
    cite(my_cite_text)
    } else {
    text(red)[#my_cite_text]
    }
  )
}




#let graph_node(pos, radius, unit:1pt, cont, offset) = {
  style(styles=>{
  let size = measure(cont,styles)
  let posu = ((pos.at(0)-radius) * unit, (pos.at(1)-radius) * unit)
  place(dx: posu.at(0), dy: posu.at(1))[#circle(inset: 1pt
  ,radius:radius*unit
  )[#cont]
  // []
]
  // place[#align(center)[hehale]]
  // place(dx: posu.at(0)+size.width/2+offset.at(0)*unit, dy: posu.at(1)+size.height/2+offset.at(1)*unit, cont)
  // place(cont)
  })
}

#let graph_arrow(start, end, pad_start: 0, pad_end: 0, arrow_len: 8pt, unit:1pt) = {
  let deg = calc.atan2(start.at(0)-end.at(0),start.at(1)-end.at(1))
  let sindeg = calc.sin(deg)
  let cosdeg = calc.cos(deg)
  let startu = ((start.at(0)-pad_start*cosdeg) * unit, (start.at(1)-pad_start*sindeg) * unit)
  let endu = ((end.at(0)+ pad_end*cosdeg) * unit, (end.at(1) + pad_end*sindeg) * unit)
  place[#line(start:startu, end:endu)]
  place[#line(start: endu, angle: deg+30deg, length: arrow_len)]
  place[#line(start: endu, angle: deg -30deg, length: arrow_len)]
}

#let graph(nodes, arrows, radius,pad_start:0, pad_end:10, offset:(0,0)) = {
  block(height: pad_start * 1pt)
  let maxy = 0
  for (pos, cont) in nodes {
    graph_node(pos,radius,cont, offset)
    maxy = calc.max(pos.at(1), maxy)
  }
  for (i1,i2) in arrows {
    graph_arrow(nodes.at(i1).at(0),nodes.at(i2).at(0), pad_start:radius, pad_end:radius)
  }
  block(height: (maxy + pad_end) * 1pt)
}

#let sep = {
  let space = -5pt
  v(space)
  line(start: (-5%,0%), length: 107.5%, stroke: 0.1pt)
  v(space)
}

#let tableofcontents = [
#text(weight: "bold", size: 1.5em)[Contents] \
#locate(loc => {
  let headings = query(heading, loc)
  for head in headings {
    if head.numbering == none {continue}
    let number = counter(heading).at(head.location())
    link(head.location(), {
      box(width: 1.5em) * (number.len()-1)
      if head.numbering != none {box(width: 1.5em + (number.len()-1) * 0.5em, numbering(head.numbering, ..number))}

      if head.level == 1 {text(weight: "bold")[#head.body]}
      else {head.body}
      box(width: 1em)
      box(repeat([.]), width: 1fr)
      box(width: 2em, align(right, [#head.location().page()]))
      linebreak()
    })
  }
  let head = headings.at(-1)
  link(head.location(), {
    box(width: 1.5em)
    text(weight: "bold")[#head.body]
    box(width: 1em)
    box(repeat([.]), width: 1fr)
    box(width: 2em, align(right, [#head.location().page()]))
  })
})
]