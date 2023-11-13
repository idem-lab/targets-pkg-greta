#' Run Pipeline
#'
#' @importFrom targets tar_make
#'
#' @return print workflow to console
#' @export
run_pipeline <- function () {
  targets::tar_make()
}
