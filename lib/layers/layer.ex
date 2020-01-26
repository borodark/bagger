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
    field: %Matrex{data: nil}
  ]

  @doc """
  Creates a new layer which is essentially represented by Agent.
  """
  def new(name, activation_function,n_of_inputs, n_of_neurons, learning_rate, field \\ []) do
     Agent.start_link(fn() ->
       %Layer{
         name: name,
         pid: self(),
         w: Matrex.random(n_of_neurons, n_of_inputs + 1),  # +1 is for bias 
         learning_rate: learning_rate,
         field: init_field(field, n_of_inputs, n_of_neurons)
       }
     end, [name: name])
  end

  @doc """
  Shows the current state of the given Layer
  """
  def get(name) do
    Agent.get(name, &(&1))
  end

  #######
  # API #
  #######
  def learn_once(layer_name, input_vector) do
    layer = get(layer_name)
    summation = summation(input_vector, layer.field, layer.w)
    #error = expected - unit_step(result)
    #errors.append(error)
    #w += eta * error * x
  end

  @doc """
  returns a vector of of summs of inputs multiplied by weight observing the feild
  for each neuron. The size is equel to number of neurons
  """
  defp summation(input_vector, field, w ) do
    # Add 1 for bias before the first value of input vector
    bias_included = Matrex.new([[1]]) |> Matrex.concat(input_vector)
    # {number_of_neurons,_} = Matrex.size(w)
    # Copy input vector number of neurons times creating matrix
    # input_matrix = inflate_input(bias_included, number_of_neurons)

    #Logger.info("Input: #{inspect input_matrix}, W:  #{inspect w}")
    Logger.info("Input: #{inspect bias_included}")
    Logger.info("W: #{inspect w}")
    # Modify given W by applying the Field! Corresponding wij will be zero and 
    #  will not contribute to the Input *  W transposed 
    w_field_applied = Matrex.multiply(w,field)
    Logger.info("W with Field applied: #{inspect w_field_applied}")
    rc = bias_included # input_matrix
    # |> Matrex.multiply(field) # already has bias
    |> Matrex.dot_nt(w_field_applied) # multiply transposing w
    Logger.info("Summation for each neuron  => #{inspect rc}")
    rc
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
    Matrex.ones(n_of_neurons, n_of_inputs + 1) # +1 is for bias
  end

  defp init_field(list_of_field_vectors, _n_of_inputs, _n_of_neurons) do
    Matrex.new(list_of_field_vectors)
  end
end
