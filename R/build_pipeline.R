#' Build Pipeline
#'
#' @importFrom targets tar_helper tar_source tar_target
#'
#' @return creates file
#' @export
build_pipeline <- function () {

  targets::tar_helper("_targets.R", {
    # Load packages required to define the pipeline:
    library(targets)
    library(greta)

    # Run the R scripts in the R/ folder with your custom functions:
    tar_source()

    # Replace the target list below with your own:
    targets <- list(

      tar_target(x, iris$Petal.Length),
      tar_target(y, iris$Sepal.Length),

      tar_target(greta_arrays, create_greta_arrays(x, y)),

      tar_target(m, model(greta_arrays$int,
                          greta_arrays$coef,
                          greta_arrays$sd)),

      tar_target(draws, mcmc(m, n_samples = 500, chains = 4))

    )
    tarchetypes::tar_hook_before(
      targets = targets,
      hook = awaken_greta_model(m),
      names = draws
    )
  })
}

