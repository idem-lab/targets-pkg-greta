modular_build_pipeline <- function (data_targets, model_targets) {

  header <- write_targets_header()
  footer <- write_targets_footer()

  writeLines(c(header,
               data_targets,
               model_targets,
               footer),
             '_targets.R')

}
write_targets_header <- function () {

  "
  # Load packages required to define the pipeline:
  library(targets)
  library(greta)

  # Run the R scripts in the R/ folder with your custom functions:
  tar_source()

  targets <- list(
  "

}
write_targets_data_module <- function (x_data_file,
                                       y_data_file) {

  paste0(
    "
    tar_target(x, ", x_data_file, "),
    tar_target(y, ", y_data_file, "),
    "
  )

}
write_targets_model <- function (n_samples, chains) {

  paste0(
    "
    tar_target(sd_greta_array, create_greta_arrays_sd()),
    tar_target(observation_greta_arrays,
               create_observation_model(sd_greta_array$sd, x, y)),

    tar_target(combined_greta_arrays,
              c(sd_greta_array, observation_greta_arrays)),

    tar_target(m, model(combined_greta_arrays$int,
                        combined_greta_arrays$coef,
                        combined_greta_arrays$sd)),

    tar_target(draws, mcmc(m, n_samples = ", n_samples, ", chains = ", chains, "4))
    "

  )

}
write_targets_footer <- function () {

  "
  )
  tarchetypes::tar_hook_before(
    targets = targets,
    hook = awaken_greta_model(m),
    names = draws
  )
  "
}


