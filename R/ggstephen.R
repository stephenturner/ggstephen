draw_key_stephen <-  function(data, params, size) {
  filename <- system.file(paste0(data$stephen, ".png"), package = "ggstephen", mustWork = TRUE)
  img <- as.raster(png::readPNG(filename))
  aspect <- dim(img)[1]/dim(img)[2]
  grid::rasterGrob(image = img)
}


stephenGrob <- function(x, y, size,
                        stephen = "stephen1",
                        geom_key = list(cat = "cat.png",
                                        stephen1="stephen1.png",
                                        stephen2="stephen2.png")) {

  filename <- system.file(geom_key[[unique(stephen)]], package = "ggstephen", mustWork = TRUE)
  img <- as.raster(png::readPNG(filename))

  grid::rasterGrob(x = x,
                   y = y,
                   image = img,
                   # only set height so that the width scales proportionally and so that the icon
                   # stays the same size regardless of the dimensions of the plot
                   height = size * ggplot2::unit(20, "mm"))
}


Geomstephen <- ggplot2::ggproto(`_class` = "Geomstephen",
                               `_inherit` = ggplot2::Geom,
                               required_aes = c("x", "y"),
                               non_missing_aes = c("size", "stephen"),
                               default_aes = ggplot2::aes(size = .8,
                                                          stephen = "stephen1",
                                                          shape  = 19,
                                                          colour = "black",
                                                          fill   = NA,
                                                          alpha  = NA,
                                                          stroke =  0.5,
                                                          scale = 5,
                                                          image_filename = "stephen1"),

                               draw_panel = function(data, panel_scales, coord, na.rm = FALSE) {
                                 coords <- coord$transform(data, panel_scales)
                                 ggplot2:::ggname(prefix = "geom_stephen",
                                                  grob = stephenGrob(x = coords$x,
                                                                     y = coords$y,
                                                                     size = coords$size,
                                                                     stephen = coords$stephen))
                               },

                               draw_key = draw_key_stephen)

#' @title Stephen layer
#' @description The geom is used to add Stephen to plots. See ?ggplot2::geom_points for more info.
#' @inheritParams ggplot2::geom_point
#' @examples
#'
#' library(ggplot2)
#'
#' ggplot(mtcars) +
#'  geom_stephen(aes(mpg, wt)) +
#'  theme_bw()
#'
#' ggplot(mtcars) +
#'  geom_stephen(aes(mpg, wt), stephen = "stephen2") +
#'  theme_bw()
#'
#' ggplot(mtcars) +
#'  geom_stephen(aes(mpg, wt), stephen = "cat") +
#'  theme_bw()
#'
#' @importFrom grDevices as.raster
#' @export
geom_stephen <- function(mapping = NULL,
                        data = NULL,
                        stat = "identity",
                        position = "identity",
                        ...,
                        na.rm = FALSE,
                        show.legend = NA,
                        inherit.aes = TRUE) {

  ggplot2::layer(data = data,
                 mapping = mapping,
                 stat = stat,
                 geom = Geomstephen,
                 position = position,
                 show.legend = show.legend,
                 inherit.aes = inherit.aes,
                 params = list(na.rm = na.rm, ...))
}
