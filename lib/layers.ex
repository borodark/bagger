defmodule Layers do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    topology = Application.get_env(:layers, :topology)
    require Logger
    Logger.info("Topology #{inspect topology}")

    children = [
      supervisor(Layers.Supervisor, [topology]),
      worker(Layers.ResultCollector, [ [:"0" , :"1"]])
    ]

    opts = [strategy: :one_for_one, name: __MODULE__]
    Supervisor.start_link(children, opts)
  end

end
