
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ggstephen

<!-- badges: start -->
<!-- badges: end -->

The goal of ggstephen is to provide additional geoms for ggplot2 plots.

## Installation

You can install the development version of ggstephen like so:

``` r
remotes::install_github("stephenturner/ggstephen")
```

## Example

This is a basic example which shows you how plot data using Stephen’s
cat:

``` r
library(ggplot2)
library(ggstephen)

ggplot(mtcars) + geom_stephen(aes(mpg, wt))

ggplot(mtcars) + geom_stephen(aes(mpg, wt), stephen = "stephen2")

ggplot(mtcars) + geom_stephen(aes(mpg, wt), stephen = "cat")
```
