defmodule Layers.Layer do
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
    #activation_function: :sigmoid,
    w: %Matrex{data: nil},
    eta: 1,
    field: %Matrex{data: nil},
    errors: %Matrex{data: nil}
  ]

  @doc """
  Creates a new layer which is essentially represented by Agent.
  """
  def new(name, activation_function,n_of_inputs, n_of_neurons, learning_rate, field \\ []) do
     Agent.start_link(fn() ->
       %Layers.Layer{
         name: name,
         pid: self(),
         w: Matrex.zeros(n_of_neurons,n_of_inputs + 1),  # +1 is for bias 
         eta: learning_rate,
         field: init_field(field, n_of_inputs, n_of_neurons),
         errors: Matrex.zeros(1,n_of_neurons)

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
  def train61(epocs) do
    data = Matrex.load("sonar.csv")
    {nrows,ncols} = Matrex.size(data)
    actualZ = data |> Matrex.column(ncols) # class is the last column
    Logger.info("actualZ = #{inspect actualZ}")
    xes_last_col = ncols - 1
    xes = data |> Matrex.submatrix(1..nrows, 1..xes_last_col) # X-es are all but last
    Logger.info("xes = #{inspect xes}")
    train(:n60x1, xes, actualZ, epocs)
  end
  def train21(epocs) do
    dataset = Matrex.load("1000-2D-2-x1x2.csv")
#    Logger.info("x1x2  = #{inspect dataset}")
    actualZ = Matrex.load("1000-2D-2-y.csv")
    Logger.info("y  = #{inspect actualZ}")
    train(:n2x1, dataset,actualZ,epocs)
  end

  def train(layer_name, dataset,actualZ,epocs) do
    # iterate over each vector of the dataset
    {nrows,_ncols} = Matrex.size(dataset)
    for e <- 1..epocs do
      epoc_errors = 0
      for i <- 1..nrows do
        layer = get(layer_name)
        input_vector  = dataset[i]
        expected = Matrex.new([[actualZ[i]]]) # vector of the size of the w
        with_bias = Matrex.new([[1]]) |> Matrex.concat(input_vector)
        {w_updates, errors} = learn_once(layer.w, layer.eta, with_bias, layer.field, expected)
        err_sq = errors |> Matrex.square
        #Logger.info("err sq = #{inspect err_sq}")
        err_sq_sum = err_sq |> Matrex.add(layer.errors)
        #Logger.info("sum of errros = #{inspect err_sq_sum}")
        w_aditions = Matrex.multiply(with_bias, Matrex.scalar(w_updates))
        if w_aditions |> Matrex.square |> Matrex.sum > 0 do
          Logger.info("Δ w: #{inspect w_aditions}")
        end
        new_W = layer.w |> Matrex.add(w_aditions)
        Agent.update(layer_name,
          fn(map) -> Map.put(map, :w, new_W)
          |> Map.put(:errors, err_sq_sum)
          end)
      end
      layer = get(layer_name)
      #Logger.info("Epoc = #{inspect e}")
      #Logger.info("Errors = #{inspect epoc_errors}")
    end
    layer = get(layer_name)
    Logger.info("layer = #{inspect layer}")
  end

  @doc """
  expectedZ - vector of Yz for all neurons
  """
  def learn_once(w_current, eta, with_bias, input_field, expectedZ) do
    infered = infer(with_bias, input_field, w_current)
    errorZ = Matrex.subtract(expectedZ, infered)
    updates = Matrex.multiply(errorZ, eta) # return vector of updates
    {updates, errorZ}
  end

  @doc """
  returns a vector of of summs of inputs multiplied by weight observing the feild
  for each neuron with activation function applied at the end.
  The size is equel to number of neurons
  """
  def infer(bias_included, field, w ) do
    # Modify given X by applying the Field
    input_field_applied = Matrex.multiply(bias_included,field)
    #Logger.info("Input with Field applied: #{inspect input_field_applied}")
    rc = input_field_applied |> Matrex.dot_nt(w) # multiply transposing w
    #Logger.info("infer rc  => #{inspect rc}")
    hard_limit(rc)
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
    Matrex.ones(n_of_neurons,n_of_inputs + 1) # +1 is for bias
  end

  defp init_field(list_of_field_vectors, _n_of_inputs, _n_of_neurons) do
    Matrex.new(list_of_field_vectors)
  end

  @doc """
  hard limit activation_function in vector form
  """
  def hard_limit(summations_vector) do
    summations_vector |> Matrex.apply(
      fn
        val, _ when val < 0 -> 0
        _,_ -> 1
      end)
  end
end
