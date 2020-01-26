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
    inference = infer(input_vector, layer.field, layer.w)
    #error = expected - unit_step(result)
    #errors.append(error)
    #w += eta * error * x
  end

  defp infer(input_vector, field, w ) do
    # Add 1 for bias before the first value of input vector
    bias_included = Matrex.new([[1]]) |> Matrex.concat(input_vector)
    {number_of_neurons,_} = Matrex.size(w)
    # Copy input vector number of neurons times creating matrix
    input_matrix = inflate_input(bias_included, number_of_neurons)
    Logger.info("Input: #{inspect input_vector}, bias included: #{inspect bias_included}, Field: #{inspect field}, W:  #{inspect w}")
    rc = input_matrix
    |> Matrex.multiply(field) # already has bias
    |> Matrex.transpose
    |> Matrex.dot(w) # bias added in constructor :new
    #|> Matrex.sum
    Logger.info("#{inspect input_vector} * #{inspect field} .  #{inspect w} sum => #{inspect rc}")
    rc
  end
#  def calculate(:hard_limit, neuron) when is_map(neuron) do
#    summation(neuron.inputs, neuron.weights)
#    |> add_bias(neuron)
#    |> hard_limit
#  end

#  def adjust(neuron, target, item) do
#    error = calculate_local_error(neuron.output, target)
#    adjust(error, neuron, item, target)
#  end

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


  @doc """
  Create matrix with copies of input vector for each neuron in the layer
  """
  def inflate_input(input_vector, times) do
    inflate_input(input_vector, times, input_vector)
  end

  def inflate_input(_input_vector, times, rc) when times <= 1, do: rc

  def inflate_input(input_vector, times, rc) do
    rc = rc |> Matrex.concat(input_vector, :rows)
    inflate_input(input_vector, times - 1, rc)
  end
end
