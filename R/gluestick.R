

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' String interpolation
#'
#' Expressions enclosed by specified delimiters will be evaluated as R code
#' within the context of the \code{src} data/environment.  The results will
#' then be inserted into the original string via \code{sprintf()}
#' i.e. string interpolation.
#'
#'
#' @param fmt single character string containing the format specification.
#' @param src data source. An \code{environment}, \code{list},
#'        \code{data.frame} or anything supported by \code{as.environment()}.
#'        Default: \code{parent.frame()} i.e. the calling environment
#' @param open,close the opening and closing character strings which delimit an expression.
#'        Default: \code{{}}.  Note: the delimiters can be more complex than
#'        just a single character
#'
#' @examples
#' gluestick("Hello {name}", list(name = '#RStats'))
#' gluestick("Hello ~!name!~", list(name = '#RStats'), open = "~!", close = "!~")
#' name <- '#RStats'; gluestick("Hello {name}")
#'
#' @export
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
gluestick <- function(fmt, src = parent.frame(), open = "{", close = "}") {

  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # Sanity checks
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  stopifnot(is.character(fmt) && length(fmt) == 1)

  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # Brute force the open/close characters into a regular expression for
  # extracting the expressions from the format string
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  nchar_open  <- nchar(open)
  nchar_close <- nchar(close)

  open  <- gsub("(.)", "\\\\\\1", open ) # Escape everything!!
  close <- gsub("(.)", "\\\\\\1", close) # Escape everything!!
  re    <- paste0(open, ".*?", close)

  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # Extract the names of the variables
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  matches  <- gregexpr(re, fmt)
  exprs    <- regmatches(fmt, matches)[[1]]

  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # Remove the braces
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  exprs <- substr(exprs, nchar_open + 1L, nchar(exprs) - nchar_close)

  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # create a valid sprintf fmt string
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  fmt_sprintf <- gsub(re, "%s", fmt)

  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # Evaluate
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  env  <- as.environment(src)
  args <- lapply(exprs, function(expr) {eval(parse(text = expr), envir = src)})

  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # Create the string(s)
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  do.call(sprintf, c(list(fmt_sprintf), args))
}




if (FALSE) {
  src <- list(name = 'mike', score = c(3, 5))
  fmt <- "hello {name} your score is {score}"

  gluestick(fmt, src)
}











