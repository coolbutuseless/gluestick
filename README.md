
<!-- README.md is generated from README.Rmd. Please edit that file -->

# gluestick

<!-- badges: start -->

![](https://img.shields.io/badge/cool-useless-green.svg)
[![R-CMD-check](https://github.com/coolbutuseless/gluestick/workflows/R-CMD-check/badge.svg)](https://github.com/coolbutuseless/gluestick/actions)
<!-- badges: end -->

The goal of the `gluestick` package is to provide a home for a single,
simple function (also named `gluestick`).

This `gluestick()` function is meant to be an almost drop-in replacement
for 99.9% of the reasons I use the amazing
[`glue`](https://cran.r-project.org/package=glue) package.

The idea is that you would just steal the function out of this package
and use it in your own package in order to avoid having
[`glue`](https://cran.r-project.org/package=glue) as a dependency.

## Benefits

-   Single function
-   No dependencies
-   No C code
-   Vanilla base R code (easy to hack upon)

## Limitations

-   There is no special handling when delimiters are repeated. This
    differs from `glue` where doubling the delimiter escpaes it.
-   No support for glue’s idea of data transformers
-   Far fewer sanity checks than glue

## Installation

You can install from
[GitHub](https://github.com/coolbutuseless/gluestick) with:

``` r
# install.package('remotes')
remotes::install_github('coolbutuseless/gluestick')
```

In reality, I can’t see anyone actually wanting to install/use this
package in preference to the glue package.

What I envisage is that if you want something “glue-like” to include in
your own work, you can just steal the `gluestick()` function out of this
package and include it in your own package.

## Basic Usage

``` r
library(gluestick)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# By default, `src` data is the calling environment
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
name <- 'Mike'
gluestick("Hello {name}")
```

    #> [1] "Hello Mike"

``` r
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# R code will be evaluated
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
gluestick("Hello {name}. Score = {1 + 2}")
```

    #> [1] "Hello Mike. Score = 3"

``` r
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Can pass in a list, data.frame, environment etc as the data source to 
# override the default
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
gluestick("Hello {name}", src = list(name = '#RStats'))
```

    #> [1] "Hello #RStats"

``` r
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Delimiters are user-definable
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
gluestick("Hello ~~!name]]?", open = "~~!", close = "]]?")
```

    #> [1] "Hello Mike"

## Related Software

-   Functionality is heavily modelled on
    [`glue`](https://cran.r-project.org/package=glue)

## Acknowledgements

-   R Core for developing and maintaining the language.
-   CRAN maintainers, for patiently shepherding packages onto CRAN and
    maintaining the repository
