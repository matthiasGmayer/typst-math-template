#import "template.typ": *
#show: sub_project

This is a citation
#ccite[pearl]

#definition[MyDefinition][
  $X=1$
]
#labeled[mydef]

#remark[
  $X!=2$
]
#proof[
  see #tref[mydef]
]

