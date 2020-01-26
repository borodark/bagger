defmodule Layer do

  require Logger
  # import Matrex

  @moduledoc """
  All Neural Networks have layers. The layers consist of number of neurons. 
  The Layer defines number of neurons, activation function used by all neurons in the layer.
  TODO custom activation for each, perhaps?
  # Inputs X Number Of Neurons matrix of weights. 
  """

  defstruct [
    pid: nil,
    activation_function: :sigmoid,
    w: %Matrex{data: nil},
    learning_rate: 1,
    feild: %Matrex{data: nil}
  ]

  @doc """
  Creates a new layer which is essentially represented by Agent.
  """
  def  new(name, n_of_inputs, n_of_neurons, learning_rate, field \\ []) do
     Agent.start_link(fn() ->
       %Layer{
         pid: self(),
         w: Matrex.random(n_of_inputs, n_of_neurons),
         learning_rate: learning_rate,
         feild: init_field(field, n_of_inputs, n_of_neurons)
       }
     end, [name: name])
  end

  @doc """
  Shows the current state of the given Layer
  """
  def get(name) do
    Agent.get(name, &(&1))
  end
  @doc """
  Setup network continuity
  The field is setup of of the list of lists representing where connection must be severed.
  Example: [[1,2], [4,5]] will make the 1st and 4th elements of input vector will never reach the 2nd and 5th neurons respectevely.

  """
  defp init_field([], n_of_inputs, n_of_neurons) do
    Matrex.ones(n_of_inputs, n_of_neurons) # Default: all TODO init from arguments?
  end
  # TODO 
  defp init_field([list_of_field_vectors], n_of_inputs, n_of_neurons) do
    # TODO remove zeros call and parse Network Continuity data
    Matrex.zeros(n_of_inputs, n_of_neurons)
    # Default: all TODO init from arguments?
  end
end
