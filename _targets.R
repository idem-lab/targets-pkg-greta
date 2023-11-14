library(targets)
library(greta)
tar_source()
targets <- list(tar_target(x, iris$Petal.Length), tar_target(y, 
    iris$Sepal.Length), tar_target(greta_arrays, create_greta_arrays(x, 
    y)), tar_target(m, model(greta_arrays$int, greta_arrays$coef, 
    greta_arrays$sd)), tar_target(draws, mcmc(m, n_samples = 500, 
    chains = 4)))
tarchetypes::tar_hook_before(targets = targets, hook = awaken_greta_model(m), 
    names = draws)
