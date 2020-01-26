defmodule Layers.ResultCollector do
  @moduledoc """
  This process is responsible for collecting the output for the Layers 
  This will show the results of a specific test and training cycle. The output
  layer is essentialy the communication layer to the outside world of the network.

  The results collected into number of lists according to number of classes the network produces
  """

  use GenServer
  require Logger
  #########
  #  API  #
  #########

  @doc """
  Starts the Output Process.
  The list of classes is [:R, :M]
  """
  def start_link(list_of_classes) do
    ## add ooutput containers for many classes
    state = list_of_classes |> Enum.map(fn x -> {x,[]} end) |> Enum.into(%{})
    # iex(8)> 1..4 |> Enum.map(fn x -> {x,[]} end) |> Enum.into(%{})
    # %{1 => [], 2 => [], 3 => [], 4 => []}
    GenServer.start_link(__MODULE__, state, [name: __MODULE__])
  end

  @doc """
  Classifies a hot item and adds it to the hot bag
  """
  def classify(a_class_atom, an_item) do
    GenServer.cast(__MODULE__, {a_class_atom, an_item})
  end

  @doc """
  Shows the contents of the bag to the user
  """
  def show do
    GenServer.call(__MODULE__, :show)
  end

  ##################
  # IMPLEMENTATION #
  ##################

  def init(classifiers) do
    {:ok, classifiers}
  end

  def handle_call(:show, _from, state) do
    make_report(state)
    #System.cmd("open", ["bagger_report.html"])
    {:reply, "Completed", state}
  end

  def handle_cast({a_class_atom, item}, state) do
    result = Map.update!(state, a_class_atom, fn(items) -> [item | items] end)
    {:noreply, result}
  end

  defp make_report(state) do
    Logger.info("#{inspect state}")
  end
end
