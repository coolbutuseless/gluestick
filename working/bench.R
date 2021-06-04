
library(bench)
library(ggplot2)
library(glue)

bar <- rep("bar", 1e1)

res <-
  bench::mark(
    glue       = glue("foo{bar}"),
    paste0     = paste0("foo", bar),
    sprintf    = sprintf("foo%s", bar),
    gluestick  = gluestick("foo{bar}"),
    gluestick2 = gluestick("foo{bar}", list(bar = bar)),
    gluestick3 = gluestick("foo{bar}", list(bar = bar), eval = TRUE),
    check = FALSE
  )

res

plot(res)

