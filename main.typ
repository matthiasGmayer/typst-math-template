#import "template.typ": *
#import datetime

// Take a look at the file `template.typ` in the file panel

#let my_abstract = [
  #lorem(40)
]
#show: project.with(
  title: "Title",
  authors: (
    (name: "MyName", email: "email@email.com"),
  ),
  abstract:my_abstract,
  date: datetime.today().display("[month repr:long] [year]"),
)
#{manage.is_main_document.update(true)}

#pagebreak()
#tableofcontents
#pagebreak()


= Introduction
#include "introduction.typ"

#pagebreak()
#bibliography(("citations.yml","citations.bib"),style:"ieee")