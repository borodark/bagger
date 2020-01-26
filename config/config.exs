# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config
#
# name of the layer, activation_function, n_of_inputs, n_of_neurons, learning_rate, field \\ []
# field: list of lists, 0 for input to be ignored # TODO will not work for big inputs, number of neurons
# The first 1 os for continuity of bias
config :layers, topology: [
  {:input_layer,:sigmoid, 5, 3, 1, [[1,1,0,1,0,1],[1,1,1,1,1,1],[1,0,1,0,1,0]] },
  {:output_layer, :sigmoid, 3, 1, 1, [] }
]
