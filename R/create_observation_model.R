#' Create Greta Arrays
#'
#' @param x x data
#' @param y y data
#'
#' @importFrom greta normal lognormal distribution
#'
#' @return greta arrays
#' @export
create_observation_model <- function (sd, x, y) {

  int <- normal(0, 5)
  coef <- normal(0, 3)

  mean <- int + coef * x

  distribution(y) <- normal(mean, sd)

  greta_arrays <- list(
    int,
    coef,
    mean
  )
  names(greta_arrays) <- c(
    'int',
    'coef',
    'mean'
  )
  greta_arrays
}
