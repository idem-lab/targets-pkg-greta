#' Create Greta Arrays
#'
#' @param x x data
#' @param y y data
#'
#' @importFrom greta normal lognormal distribution
#'
#' @return greta arrays
#' @export
create_greta_arrays <- function (x, y) {

  int <- normal(0, 5)
  coef <- normal(0, 3)
  sd <- lognormal(0, 3)

  mean <- int + coef * x
  distribution(y) <- normal(mean, sd)

  greta_arrays <- list(
    int,
    coef,
    sd,
    mean
  )
  names(greta_arrays) <- c(
    'int',
    'coef',
    'sd',
    'mean'
  )
  greta_arrays
}
