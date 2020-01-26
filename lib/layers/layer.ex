defmodule Layer do
  # TODO perhaps use gen_server?
  require Logger
  # import Matrex

  @moduledoc """
  All Neural Networks have layers. The layers consist of number of neurons. 
  The Layer defines number of neurons, activation function used by all neurons in the layer.
  TODO custom activation for each, perhaps?
  # Inputs X Number Of Neurons matrix of weights. 
  """

  defstruct [
    name: nil,
    pid: nil,
    activation_function: :sigmoid,
    w: %Matrex{data: nil},
    learning_rate: 1,
    feild: %Matrex{data: nil}
  ]

  @doc """
  Creates a new layer which is essentially represented by Agent.
  """
  def  new(name, activation_function,n_of_inputs, n_of_neurons, learning_rate, field \\ []) do
     Agent.start_link(fn() ->
       %Layer{
         name: name,
         pid: self(),
         w: Matrex.random(n_of_inputs + 1, n_of_neurons),  # +1 is for bias 
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
  The field is setup of of the list of lists representing where connection must be established - 1, or severed - 0.
  Example: [[1,1,0,1], [1,0,1,0]]
  - bias + three inputs, two neurons
  - The 1st neureon ignores input 2
  - The second neuron ignores input 1 and 3 

  """
  defp init_field([], n_of_inputs, n_of_neurons) do
    Matrex.ones(n_of_inputs + 1, n_of_neurons) # +1 is for bias
  end

  defp init_field(list_of_field_vectors, _n_of_inputs, _n_of_neurons) do
    Matrex.new(list_of_field_vectors)
  end
end
