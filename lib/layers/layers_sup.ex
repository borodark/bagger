defmodule Layers.Supervisor do
  @moduledoc """
  Supervisor responsible for the layers.
  """
  use Supervisor

  @doc """
  Starts the first layer which is a `Supervisor` process
  """
  def start_link(topology) do
    Supervisor.start_link(__MODULE__, [topology], [name: __MODULE__])
  end

  def init([topology]) do
    require Logger
    Logger.info("#{inspect topology}")
    children = Enum.map(topology,
      fn({layer_name, activation_function, inputs, neurons, learning_rate, field, datafilename}) ->
        worker(Layer,
          [layer_name, activation_function, inputs, neurons, learning_rate, field, datafilename],
          [id: layer_name, function: :new])
      end)
    supervise(children, [strategy: :one_for_one])
  end
end
