defmodule Bagger.Workers.Neuron do

  require Logger

  @moduledoc """
  All Neural Networks need neurons to get their work done. `Bagger` needs
  neurons as well in order to bag items in the grocery list. The neruon
  will take inputs and generate random weights for each input. Then it will
  train itself toward the target until it converges on the right answer.
  """

  alias Bagger.Workers.Activations

  defstruct [
    pid: nil,
    bias: nil,
    inputs: nil,
    weights: nil,
    output: nil,
    learning_rate: 1

  ]

  @doc """
  Creates a new neuron for `Bagger` which is essentially represented as an
  Agent.
  field is the indexes of input that newron is sencitive too:
  the [1,2] will set the filter to only accept signal from element 1 and 2 of the input vector
  {iis, v_field} = field |> Enum.map_reduce(ifield, fn i, i_f -> {i, Matrex.set(i_f,1, i,1)} end)
  """
  def  new(learning_rate, field \\ []) do

     Agent.start_link(fn() ->
       %Bagger.Workers.Neuron{
         pid: self(),
         bias: 1,
         learning_rate: learning_rate
       }
     end, [name: __MODULE__])
  end

  @doc """
  Shows the current state of the given Neuron.
  """
  def get do
    Agent.get(__MODULE__, &(&1))
  end

  @doc """
   Add inputs to neuron so that it can classify the item.
   takes a list of
  """
  def add_inputs(data) when is_list(data) do
    [item, input_data] = data
    target = List.last(input_data)
    inputs = List.delete_at(input_data, -1)
    :sfmt.seed :os.timestamp

    Agent.update(__MODULE__,
      fn(map) ->
        Map.put(map, :inputs, inputs)
          |> Map.put(:weights, 1..length(inputs) |> Enum.map(fn(_) -> :sfmt.uniform() end))
      end)
    Logger.info("Adding input #{inspect item} -> #{inspect target} => #{inspect inputs}")
    calculate_output()
    neuron = get()
    Activations.adjust(neuron, target, item)
  end

  def update(new_weights, new_bias, target, item) do
    Agent.update(__MODULE__, fn(map) ->
      Map.put(map, :weights, new_weights)
      |> Map.put(:bias, new_bias)
    end)
    calculate_output()
    Activations.adjust(get(), target, item)
  end

  @doc """
  Calculates the output of the Neuron using the `hard_limit` transfer function
  """
  def calculate_output do
    new_output = Activations.calculate(:hard_limit, get())
     Agent.update(__MODULE__, fn(map) ->
       Map.put(map, :output, new_output)
     end)
  end
end
