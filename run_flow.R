# run flow
R.utils::sourceDirectory('R/')

data_targets <- write_targets_data_module(
  x_data_file = 'iris$Petal.Length',
  y_data_file = 'iris$Sepal.Length')

model_targets <- write_targets_model(
  n_samples = 1000,
  chains = 4)

modular_build_pipeline(data_targets,
                       model_targets)

targets::tar_visnetwork(targets_only = TRUE)

targets::tar_make()
