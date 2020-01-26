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

  @doc """

  """
  def train(epocs, input, result) do
    xy = [
      {[0,0,1],0},
      {[0,1,1],1},
      {[1,0,1],1},
      {[1,1,1],1}
    ]
    require Logger    
    y = Matrex.new([[0,1,1,1]])
    Logger.info("#{inspect y}")

    # for i in xrange(n): for epoc times 
    {x, expected} = Enum.random(xy)
  end

end
