# typst-math-template
Allows for globally numbered Definitions, Theorems, etc.

Allows for compilation of subfiles and referencing of Theorems, etc. by using custom citations and references.

Example
```
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
```
![image](https://github.com/matthiasGmayer/typst-math-template/assets/28257008/2445b5f5-138e-4d79-b795-e916b58e18d5)


Example PDF: https://drive.google.com/file/d/1RhTViesnDWg07kJuUAJ1CDqYahtzqYLo

Source Code: https://typst.app/project/rJeB-bWl2aAzffB8YiYMew

