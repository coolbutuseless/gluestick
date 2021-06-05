test_that("multiplication works", {


  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  src <- list(name = 'mike', score = c(3, 5))
  fmt <- "hello {name} your score is {score}"

  expect_identical(
    gluestick(fmt, src),
    c("hello mike your score is 3", "hello mike your score is 5")
  )


  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  src <- list(name = 'mike', score = c(3, 5))
  fmt <- "hello ??name? your score is ??score??"

  expect_identical(
    gluestick(fmt, src, open = '??', close = '?'),
    c("hello mike your score is 3?", "hello mike your score is 5?")
  )

  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  src <- list(name = 'mike', score = c(3, 5))
  fmt <- "hello {name} your score is {score}"

  expect_identical(
    gluestick(fmt, src),
    c("hello mike your score is 3", "hello mike your score is 5")
  )

  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  src <- list(name = 'mike')
  fmt <- "hello {name} your score is {8 + 1}"

  expect_identical(
    gluestick(fmt, src),
    c("hello mike your score is 9")
  )

  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  fmt <- "hello {name} your score is {8 + 1}"
  src <- list(name = 'mike')

  expect_error(
    gluestick(fmt, src, eval = FALSE),
    "not found"
  )


})
