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
    #activation_function: :sigmoid,
    datafilename: nil,
    w: %Matrex{data: nil},
    eta: 1,
    field: %Matrex{data: nil},
    actual: %Matrex{data: nil},
    predicted: %Matrex{data: nil}
  ]

  @doc """
  Creates a new layer which is essentially represented by Agent.
  """
  def new(name, _activation_function, n_of_inputs, n_of_neurons, learning_rate, field \\ [], datafilename) do
     Agent.start_link(fn() ->
       %Layer{
         name: name,
         pid: self(),
         datafilename: datafilename,
         w: Matrex.random(n_of_neurons, n_of_inputs + 1),  # +1 is for bias 
         eta: learning_rate,
         field: init_field(field, n_of_inputs, n_of_neurons),
         actual: Matrex.zeros(n_of_neurons), 
         predicted: Matrex.zeros(n_of_neurons)
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
  def train(layer_name, epocs ) do
    # TODO open data
    layer = get(layer_name)
    #dataset = Matrex.load(layer.datafilename)
    
    dataset = Matrex.new([[2.7810836,2.550537003,0],
	                        [1.465489372,2.362125076,0],
	                        [3.396561688,4.400293529,0],
	                        [1.38807019,1.850220317,0],
	                        [3.06407232,3.005305973,0],
	                        [7.627531214,2.759262235,1],
	                        [5.332441248,2.088626775,1],
	                        [6.922596716,1.77106367,1],
	                        [8.675418651,-0.242068655,1],
	                        [7.673756466,3.508563011,1]])
    # {nrows,ncols} = Matrex.size(dataset)
    Logger.info("Dataset #{inspect dataset}")
    x1x2 = Matrex.concat(dataset |> Matrex.column(1),dataset |> Matrex.column(2), :columns)
    actualZ = dataset |> Matrex.column(3)
    Logger.info("X1, X2 =>  #{inspect x1x2}")
    Logger.info("Y =>  #{inspect actualZ}")
    train(epocs, layer_name, x1x2, actualZ )
  end

  def train(epocs, layer_name, train_dataZ, actualZ ) do

    {nrows,_ncols} = Matrex.size(train_dataZ)
    for e <- 1..epocs do
      for i <- 1..nrows do
        layer = get(layer_name)
        input_vector  = train_dataZ[i] #TODO
        actual  = Matrex.new([[actualZ[i]]])
        Logger.info("Input Vector  = #{inspect input_vector} , Y = #{inspect actual}")
        {w_updates, errors, actuals, predicted} = learn_once(layer_name,input_vector, actual)
        Logger.info("Actual  = #{inspect actual} , Predicted = #{inspect predicted}")
        new_actual = actual |> Matrex.concat(layer.actual, :rows)
        new_predicted = predicted |> Matrex.concat(layer.predicted, :rows)
        w_u = Matrex.concat(errors |> Matrex.multiply(layer.eta), Matrex.dot_tn(w_updates,input_vector))
        Logger.info("W updates = #{inspect w_u}")
        new_W = layer.w |> Matrex.add(w_u)
        Logger.info("new W = #{inspect new_W}")
        Agent.update(layer_name,
          fn(map) ->
            Map.put(map, :w, new_W)
            |> Map.put(:actual, new_actual)
            |> Map.put(:predicted, new_predicted)
          end)
      end
      Logger.info("Epoc: #{inspect e}")
      Logger.info("MSE:  #{inspect e}") # TODO
      Logger.info("Confusion Matrix:  #{inspect e}") # TODO

    end
    layer = get(layer_name)
    Logger.info("layer = #{inspect layer}")
  end

  @doc """
  expectedZ - vector of Yz for all neurons AKA `Actual`
  """
  def learn_once(layer_name, input_vector, actual) do
    layer = get(layer_name)
    predicted = infer(input_vector,layer.field, layer.w)##
    Logger.info("predicted #{inspect predicted}")
    Logger.info("actual #{inspect actual}")

    errorZ = Matrex.subtract(actual, predicted) # actual - predicted
    updates = Matrex.multiply(errorZ, layer.eta) # return vector of updates
    {updates, errorZ ,actual, predicted}
  end

  @doc """
  returns a vector of of summs of inputs multiplied by weight observing the feild
  for each neuron with activation function applied at the end.
  The size is equel to number of neurons
  """
  defp infer(input_vector, field, w) do
    # Add 1 for bias before the first value of input vector
    bias_included = Matrex.new([[1]]) |> Matrex.concat(input_vector)
    # Modify given W by applying the Field: Corresponding wij will be zero and 
    #  will not contribute to the Input *  W transposed 
    w_field_applied = Matrex.multiply(w,field)
    #  Logger.info("W with Field applied: #{inspect w_field_applied}")
    rc = bias_included |> Matrex.dot_nt(w_field_applied) # multiply transposing w
    Logger.info("Summation for each neuron  => #{inspect rc}")
    {n_of_classes,_} = w[:size]
    Logger.info("NK  => #{inspect n_of_classes}")
    hard_limit(n_of_classes,rc)     # Matrex.Operators.sigmoid(rc)
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
    Matrex.ones(n_of_neurons, n_of_inputs + 1) # +1 is for bias
  end

  defp init_field(list_of_field_vectors, _n_of_inputs, _n_of_neurons) do
    Matrex.new(list_of_field_vectors)
  end

  @doc """

  hard limit activation_function in vector form
  TODO hardcoded for datasets
  """
  def hard_limit(1, summations_vector) do
    summations_vector |> Matrex.apply(
      fn
        val, _ when val < 0  -> 0
        _,_ -> 1
      end)
  end

  def hard_limit(3, summations_vector) do
    summations_vector |> Matrex.apply(
      fn
        val, _ when val < 0  -> 1
        _,_ -> 2
      end)
  end
end
