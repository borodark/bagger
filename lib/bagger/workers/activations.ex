defmodule Bagger.Workers.Activations do
  @moduledoc """
  Does all the calculations for the neurons. It will adjust the weights
  and bias accordingly until it reaches the target that is set.
  """
  require Logger
  #use GenServer


  #######
  # API #
  #######

  def calculate(:hard_limit, neuron) when is_map(neuron) do
    summation(neuron.inputs, neuron.weights)
    |> add_bias(neuron)
    |> hard_limit
  end

  def adjust(neuron, target, item) do
    error = calculate_local_error(neuron.output, target)
    adjust(error, neuron, item, target)
  end

  ##################
  # IMPLEMENTATION #
  ##################

  defp add_bias(calc, neuron), do: calc + neuron.bias
  defp calculate_local_error(actual, target), do: target - actual
  defp hard_limit(calc) when calc < 0, do: 0
  defp hard_limit(calc) when calc >= 0, do: 1

  defp summation([], []), do: 0

  # #Matrex<> inputs and weigths
  defp summation(inputs, weights) do
    Matrex.dot(Matrex.new([inputs]), Matrex.new([weights]) |> Matrex.transpose )
    |> Matrex.sum
  end

  defp adjust(0, neuron, item, target) do
    Logger.info("#{inspect item} -> #{inspect target} => #{inspect neuron.bias} #{inspect neuron.weights} e: 0")
    Bagger.Workers.Output.classify(neuron.output, item)
  end

  defp adjust(error, neuron, item, target) do
    new_weights =
      Matrex.new([neuron.weights])
      |> Matrex.multiply(error * neuron.learning_rate)
      |> Matrex.add(Matrex.new([neuron.inputs]))
      |> Matrex.to_list  # List.flatten # return #Matrex

    new_bias = neuron.bias + ( error * neuron.learning_rate )

    Logger.info("#{inspect item} -> #{inspect target} => #{inspect new_bias} #{inspect new_weights} e: #{inspect error}")
    Bagger.Workers.Neuron.update(new_weights, new_bias, target, item)
  end
end
