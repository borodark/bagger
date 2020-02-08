use Mix.Config
#
# name of the layer, activation_function, n_of_inputs, n_of_neurons, learning_rate, field \\ []
# field: list of lists, 0 for input to be ignored # TODO will not work for big inputs, number of neurons
# The first 1 os for continuity of bias
config :layers, topology: [
  # {:output_layer63, :sigmoid, 6, 3, 1, [[1,1,1,0,1,0,1],[1,1,1,1,1,1,1],[1,1,0,1,0,1,0]] } # restricted field
  {:n60x1, :hard_limit, 60, 1, 0.2, [] }, # full continuity
  {:n2x1, :hard_limit, 2, 1, 0.2, [] } # full continuity
]
