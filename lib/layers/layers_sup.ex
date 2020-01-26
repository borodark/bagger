defmodule Layers.Supervisor do
  @moduledoc """
  The layer Supervisor is responsible for a layer.
  """
  use Supervisor

  @doc """
  Starts the first layer which is a `Supervisor` process
  TODO Multilayer?
  """
  def start_link(topology) do
    Supervisor.start_link(__MODULE__, [topology], [name: __MODULE__])
  end

  def init([topology]) do
    require Logger
    Logger.info("#{inspect topology}")
    # TODO parse topology and build list of the `Layer` workers
    # name, inputs, neurons, learning_rate, field - what inputs to ignore
    # {:input_layer,:sigmoid, 5, 3, 1, [1,4] },

    children = Enum.map(topology,
      fn({layer_name, activation_function, inputs, neurons, learning_rate, field}) ->
        worker(Layer, [layer_name, activation_function, inputs, neurons, learning_rate, field], [id: layer_name, function: :new])
      end)
    #children = [
    #  worker(Layer, [:input_layer,3,2,0.9], [function: :new])
    #]
    supervise(children, [strategy: :one_for_one])
  end
end
