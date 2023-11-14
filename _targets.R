
  # Load packages required to define the pipeline:
  library(targets)
  library(greta)

  # Run the R scripts in the R/ folder with your custom functions:
  tar_source()

  targets <- list(
  

    tar_target(x, iris$Petal.Length),
    tar_target(y, iris$Sepal.Length),
    

    tar_target(sd_greta_array, create_greta_arrays_sd()),
    tar_target(observation_greta_arrays,
               create_observation_model(sd_greta_array$sd, x, y)),

    tar_target(combined_greta_arrays,
              c(sd_greta_array, observation_greta_arrays)),

    tar_target(m, model(combined_greta_arrays$int,
                        combined_greta_arrays$coef,
                        combined_greta_arrays$sd)),

    tar_target(draws, mcmc(m, n_samples = 1000, chains = 44))
    

  )
  tarchetypes::tar_hook_before(
    targets = targets,
    hook = awaken_greta_model(m),
    names = draws
  )
  
