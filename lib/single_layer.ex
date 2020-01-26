defmodule SingleLayer do
  use Application

  @grocery_list "lib/bagger/grocery_lists/whole_foods.csv"

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    topology = Application.get_env(:layers, :topology)
    require Logger
    Logger.info("Topology #{inspect topology}")

    children = [
      supervisor(Layers.Supervisor, [topology]), # TODO supply data for layers? pass topology?
      worker(Layers.ResultCollector, [ [:"0" , :"1"]])
    ]

    opts = [strategy: :one_for_one, name: __MODULE__]
    Supervisor.start_link(children, opts)
  end

end
