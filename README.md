# HW 1 

## Choice #1: Implementation of a Perceptron NetworkThis Project is for Educational Purposes Only

The programm is implemented in [`Elixir`](https://elixir-lang.org/) language
Please refer to [install guide](https://elixir-lang.org/install.html)
Clone this repo and `cd` the projec directory


```Elixir
  #after cloning
  mix deps.get
  #start console
  iex -S mix
```
The project relyes on [Matrex project](https://github.com/versilov/matrex) for all matrix manipultions - the Elixir interface to `CBLAS`. 

Start `elixir REPL` by `iex -S mix`

To start training of `:output_layer21` for 10 epocs run this command being in elixir console: 

```Elixir
  Layer.train(10, :output_layer21)
```

### Design details

#### Layer superviser
Each `layer` runs in it's own process, supervized by application supervisor:

[layers_sup.ex](lib/layers/layers_sup.ex)

The supervisor is passed the `topology` from [config.exs](config/config.exs#8) that creates all the layers as separate processes:

```Elixir
    children = Enum.map(topology,
      fn({layer_name, activation_function, inputs, neurons, learning_rate, field}) ->
        worker(Layer,
          [layer_name, activation_function, inputs, neurons, learning_rate, field],
          [id: layer_name, function: :new])
      end)
    supervise(children, [strategy: :one_for_one])

```

#### most important functions

* [infer](lib/layers/layer.ex#124)
* [learn_once](lib/layers/layer.ex#105)
* [train](lib/layers/layer.ex#59)


### Any number of input and output nodes
The [Layer](lib/layers/layer.ex) supports any number of input and output with configuration in [config.exs](config/config.exs)
The layer bellow is configured with 2 inputs and 1 output 
```
  {:output_layer21, :hard_limit, 2, 1, 0.5, [] } # full continuity
```

### Continuum of fully-connected networks and partially-connected networks
The [config.exs](config/config.exs) supports the specification of `field` with lists of `1` or `0` 

```
config :layers, topology: [
  # {:input_layer,:sigmoid, 5, 3, 1, [[1,1,0,1,0,1],[1,1,1,1,1,1],[1,0,1,0,1,0]] }, # restricted field
```
The `field` defined as folowing for 5 input and 3 output: 
```
[[1,1,0,1,0,1],[1,1,1,1,1,1],[1,0,1,0,1,0]]
```
Each list has 6 elements for 5 inputs to accomodate `bias`


### Provision for the user to provide:
- Network configuration information,
- Learning rate, and

The [config.exs](config/config.exs) supports the specification of number of inputs and number of outputs:
```
  {:output_layer21, :hard_limit, 2, 1, 0.5, [] } # full continuity
```
The `2` is number of inputs `1` - outputs, `0.5` - eta AKA learning rate, `[]` is the empty list of `field`

TODO - Location of training and testing data sets through a parameter file that can be passed to the executable

This feature is not yet implemented but I am working on it.

### Program should provide constant feedback to the user in terms of network performance during training and execution

The output shown bellow is the result of running `:output_layer21` that is configured with full continuity of two inputs, one output that uses `:hard_limit` activation function.  

The dataset used to training is embeded into the code so far: 

[Layer.ex](lib/layers/layer.ex#51)


#### Output
`Input Vector` shows vector from dataset
`Y = ..` shows target value
`W updates = ... ` prints the concluded updates to the `W`
`new W = ..` shows new valuse for `W`
 
```Elixir

iex(1)> Layer.train(5, :output_layer21)

23:18:47.652 [info]  Input Vector  = #Matrex[1×2]
┌                 ┐
│ 2.78108 2.55054 │
└                 ┘ , Y = 0.0
 
23:18:47.652 [info]  W updates = #Matrex[1×3]
┌                         ┐
│    -0.5-1.39054-1.27527 │ 
└                         ┘
 
23:18:47.652 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.44913-0.43622-1.22847 │
└                         ┘
 
23:18:47.652 [info]  Input Vector  = #Matrex[1×2]
┌                 ┐
│ 1.46549 2.36213 │
└                 ┘ , Y = 0.0
 
23:18:47.652 [info]  W updates = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
23:18:47.652 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.44913-0.43622-1.22847 │
└                         ┘
 
23:18:47.652 [info]  Input Vector  = #Matrex[1×2]
┌                 ┐
│ 3.39656 4.40029 │
└                 ┘ , Y = 0.0
 
23:18:47.652 [info]  W updates = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
23:18:47.653 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.44913-0.43622-1.22847 │
└                         ┘
 
23:18:47.653 [info]  Input Vector  = #Matrex[1×2]
┌                 ┐
│ 1.38807 1.85022 │
└                 ┘ , Y = 0.0
 
23:18:47.653 [info]  W updates = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
23:18:47.653 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.44913-0.43622-1.22847 │
└                         ┘
 
23:18:47.653 [info]  Input Vector  = #Matrex[1×2]
┌                 ┐
│ 3.06407 3.00531 │
└                 ┘ , Y = 0.0
 
23:18:47.653 [info]  W updates = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
23:18:47.653 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.44913-0.43622-1.22847 │
└                         ┘
 
23:18:47.653 [info]  Input Vector  = #Matrex[1×2]
┌                 ┐
│ 7.62753 2.75926 │
└                 ┘ , Y = 1.0
 
23:18:47.653 [info]  W updates = #Matrex[1×3]
┌                         ┐
│     0.5 3.81377 1.37963 │ 
└                         ┘
 
23:18:47.653 [info]  new W = #Matrex[1×3]
┌                         ┐
│ 0.05087 3.37755 0.15116 │
└                         ┘
 
23:18:47.653 [info]  Input Vector  = #Matrex[1×2]
┌                 ┐
│ 5.33244 2.08863 │
└                 ┘ , Y = 1.0
 
23:18:47.653 [info]  W updates = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
23:18:47.653 [info]  new W = #Matrex[1×3]
┌                         ┐
│ 0.05087 3.37755 0.15116 │
└                         ┘
 
23:18:47.654 [info]  Input Vector  = #Matrex[1×2]
┌                 ┐
│  6.9226 1.77106 │
└                 ┘ , Y = 1.0
 
23:18:47.654 [info]  W updates = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
23:18:47.654 [info]  new W = #Matrex[1×3]
┌                         ┐
│ 0.05087 3.37755 0.15116 │
└                         ┘
 
23:18:47.654 [info]  Input Vector  = #Matrex[1×2]
┌                 ┐
│ 8.67542-0.24207 │
└                 ┘ , Y = 1.0
 
23:18:47.654 [info]  W updates = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
23:18:47.654 [info]  new W = #Matrex[1×3]
┌                         ┐
│ 0.05087 3.37755 0.15116 │
└                         ┘
 
23:18:47.654 [info]  Input Vector  = #Matrex[1×2]
┌                 ┐
│ 7.67376 3.50856 │
└                 ┘ , Y = 1.0
 
23:18:47.654 [info]  W updates = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
23:18:47.654 [info]  new W = #Matrex[1×3]
┌                         ┐
│ 0.05087 3.37755 0.15116 │
└                         ┘
 
23:18:47.654 [info]  Epoc = 1
 
23:18:47.654 [info]  Input Vector  = #Matrex[1×2]
┌                 ┐
│ 2.78108 2.55054 │
└                 ┘ , Y = 0.0
 
23:18:47.654 [info]  W updates = #Matrex[1×3]
┌                         ┐
│    -0.5-1.39054-1.27527 │ 
└                         ┘
 
23:18:47.654 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.44913 1.98701-1.12411 │
└                         ┘
 
23:18:47.654 [info]  Input Vector  = #Matrex[1×2]
┌                 ┐
│ 1.46549 2.36213 │
└                 ┘ , Y = 0.0
 
23:18:47.654 [info]  W updates = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
23:18:47.655 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.44913 1.98701-1.12411 │
└                         ┘
 
23:18:47.655 [info]  Input Vector  = #Matrex[1×2]
┌                 ┐
│ 3.39656 4.40029 │
└                 ┘ , Y = 0.0
 
23:18:47.655 [info]  W updates = #Matrex[1×3]
┌                         ┐
│    -0.5-1.69828-2.20015 │ 
└                         ┘
 
23:18:47.655 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.94913 0.28872-3.32426 │
└                         ┘
 
23:18:47.655 [info]  Input Vector  = #Matrex[1×2]
┌                 ┐
│ 1.38807 1.85022 │
└                 ┘ , Y = 0.0
 
23:18:47.655 [info]  W updates = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
23:18:47.655 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.94913 0.28872-3.32426 │
└                         ┘
 
23:18:47.655 [info]  Input Vector  = #Matrex[1×2]
┌                 ┐
│ 3.06407 3.00531 │
└                 ┘ , Y = 0.0
 
23:18:47.655 [info]  W updates = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
23:18:47.655 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.94913 0.28872-3.32426 │
└                         ┘
 
23:18:47.655 [info]  Input Vector  = #Matrex[1×2]
┌                 ┐
│ 7.62753 2.75926 │
└                 ┘ , Y = 1.0
 
23:18:47.655 [info]  W updates = #Matrex[1×3]
┌                         ┐
│     0.5 3.81377 1.37963 │ 
└                         ┘
 
23:18:47.655 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.44913 4.10249-1.94463 │
└                         ┘
 
23:18:47.656 [info]  Input Vector  = #Matrex[1×2]
┌                 ┐
│ 5.33244 2.08863 │
└                 ┘ , Y = 1.0
 
23:18:47.656 [info]  W updates = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
23:18:47.656 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.44913 4.10249-1.94463 │
└                         ┘
 
23:18:47.656 [info]  Input Vector  = #Matrex[1×2]
┌                 ┐
│  6.9226 1.77106 │
└                 ┘ , Y = 1.0
 
23:18:47.656 [info]  W updates = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
23:18:47.656 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.44913 4.10249-1.94463 │
└                         ┘
 
23:18:47.656 [info]  Input Vector  = #Matrex[1×2]
┌                 ┐
│ 8.67542-0.24207 │
└                 ┘ , Y = 1.0
 
23:18:47.656 [info]  W updates = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
23:18:47.656 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.44913 4.10249-1.94463 │
└                         ┘
 
23:18:47.657 [info]  Input Vector  = #Matrex[1×2]
┌                 ┐
│ 7.67376 3.50856 │
└                 ┘ , Y = 1.0
 
23:18:47.657 [info]  W updates = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
23:18:47.657 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.44913 4.10249-1.94463 │
└                         ┘
 
23:18:47.657 [info]  Epoc = 2
 
23:18:47.657 [info]  Input Vector  = #Matrex[1×2]
┌                 ┐
│ 2.78108 2.55054 │
└                 ┘ , Y = 0.0
 
23:18:47.657 [info]  W updates = #Matrex[1×3]
┌                         ┐
│    -0.5-1.39054-1.27527 │ 
└                         ┘
 
23:18:47.657 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.94913 2.71195 -3.2199 │
└                         ┘
 
23:18:47.657 [info]  Input Vector  = #Matrex[1×2]
┌                 ┐
│ 1.46549 2.36213 │
└                 ┘ , Y = 0.0
 
23:18:47.657 [info]  W updates = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
23:18:47.657 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.94913 2.71195 -3.2199 │
└                         ┘
 
23:18:47.657 [info]  Input Vector  = #Matrex[1×2]
┌                 ┐
│ 3.39656 4.40029 │
└                 ┘ , Y = 0.0
 
23:18:47.657 [info]  W updates = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
23:18:47.658 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.94913 2.71195 -3.2199 │
└                         ┘
 
23:18:47.658 [info]  Input Vector  = #Matrex[1×2]
┌                 ┐
│ 1.38807 1.85022 │
└                 ┘ , Y = 0.0
 
23:18:47.658 [info]  W updates = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
23:18:47.658 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.94913 2.71195 -3.2199 │
└                         ┘
 
23:18:47.658 [info]  Input Vector  = #Matrex[1×2]
┌                 ┐
│ 3.06407 3.00531 │
└                 ┘ , Y = 0.0
 
23:18:47.658 [info]  W updates = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
23:18:47.658 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.94913 2.71195 -3.2199 │
└                         ┘
 
23:18:47.658 [info]  Input Vector  = #Matrex[1×2]
┌                 ┐
│ 7.62753 2.75926 │
└                 ┘ , Y = 1.0
 
23:18:47.658 [info]  W updates = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
23:18:47.659 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.94913 2.71195 -3.2199 │
└                         ┘
 
23:18:47.659 [info]  Input Vector  = #Matrex[1×2]
┌                 ┐
│ 5.33244 2.08863 │
└                 ┘ , Y = 1.0
 
23:18:47.659 [info]  W updates = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
23:18:47.659 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.94913 2.71195 -3.2199 │
└                         ┘
 
23:18:47.659 [info]  Input Vector  = #Matrex[1×2]
┌                 ┐
│  6.9226 1.77106 │
└                 ┘ , Y = 1.0
 
23:18:47.659 [info]  W updates = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
23:18:47.659 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.94913 2.71195 -3.2199 │
└                         ┘
 
23:18:47.659 [info]  Input Vector  = #Matrex[1×2]
┌                 ┐
│ 8.67542-0.24207 │
└                 ┘ , Y = 1.0
 
23:18:47.659 [info]  W updates = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
23:18:47.659 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.94913 2.71195 -3.2199 │
└                         ┘
 
23:18:47.659 [info]  Input Vector  = #Matrex[1×2]
┌                 ┐
│ 7.67376 3.50856 │
└                 ┘ , Y = 1.0
 
23:18:47.660 [info]  W updates = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
23:18:47.660 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.94913 2.71195 -3.2199 │
└                         ┘

23:18:47.660 [info]  Epoc = 3
 
23:18:47.660 [info]  Input Vector  = #Matrex[1×2]
┌                 ┐
│ 2.78108 2.55054 │
└                 ┘ , Y = 0.0
 
23:18:47.660 [info]  W updates = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
23:18:47.660 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.94913 2.71195 -3.2199 │
└                         ┘
 
23:18:47.660 [info]  Input Vector  = #Matrex[1×2]
┌                 ┐
│ 1.46549 2.36213 │
└                 ┘ , Y = 0.0
 
23:18:47.660 [info]  W updates = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
23:18:47.660 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.94913 2.71195 -3.2199 │
└                         ┘
 
23:18:47.660 [info]  Input Vector  = #Matrex[1×2]
┌                 ┐
│ 3.39656 4.40029 │
└                 ┘ , Y = 0.0
 
23:18:47.660 [info]  W updates = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
23:18:47.660 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.94913 2.71195 -3.2199 │
└                         ┘
 
23:18:47.660 [info]  Input Vector  = #Matrex[1×2]
┌                 ┐
│ 1.38807 1.85022 │
└                 ┘ , Y = 0.0
 
23:18:47.660 [info]  W updates = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
23:18:47.660 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.94913 2.71195 -3.2199 │
└                         ┘
 
23:18:47.660 [info]  Input Vector  = #Matrex[1×2]
┌                 ┐
│ 3.06407 3.00531 │
└                 ┘ , Y = 0.0
 
23:18:47.660 [info]  W updates = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
23:18:47.661 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.94913 2.71195 -3.2199 │
└                         ┘
 
23:18:47.661 [info]  Input Vector  = #Matrex[1×2]
┌                 ┐
│ 7.62753 2.75926 │
└                 ┘ , Y = 1.0
 
23:18:47.661 [info]  W updates = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
23:18:47.661 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.94913 2.71195 -3.2199 │
└                         ┘
 
23:18:47.661 [info]  Input Vector  = #Matrex[1×2]
┌                 ┐
│ 5.33244 2.08863 │
└                 ┘ , Y = 1.0
 
23:18:47.661 [info]  W updates = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
23:18:47.661 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.94913 2.71195 -3.2199 │
└                         ┘
 
23:18:47.661 [info]  Input Vector  = #Matrex[1×2]
┌                 ┐
│  6.9226 1.77106 │
└                 ┘ , Y = 1.0
 
23:18:47.661 [info]  W updates = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
23:18:47.661 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.94913 2.71195 -3.2199 │
└                         ┘
 
23:18:47.661 [info]  Input Vector  = #Matrex[1×2]
┌                 ┐
│ 8.67542-0.24207 │
└                 ┘ , Y = 1.0
 
23:18:47.661 [info]  W updates = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
23:18:47.661 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.94913 2.71195 -3.2199 │
└                         ┘
 
23:18:47.661 [info]  Input Vector  = #Matrex[1×2]
┌                 ┐
│ 7.67376 3.50856 │
└                 ┘ , Y = 1.0
 
23:18:47.661 [info]  W updates = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
23:18:47.661 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.94913 2.71195 -3.2199 │
└                         ┘
 
23:18:47.662 [info]  Epoc = 4
 
23:18:47.662 [info]  Input Vector  = #Matrex[1×2]
┌                 ┐
│ 2.78108 2.55054 │
└                 ┘ , Y = 0.0
 
23:18:47.662 [info]  W updates = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
23:18:47.662 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.94913 2.71195 -3.2199 │
└                         ┘
 
23:18:47.662 [info]  Input Vector  = #Matrex[1×2]
┌                 ┐
│ 1.46549 2.36213 │
└                 ┘ , Y = 0.0
 
23:18:47.662 [info]  W updates = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
23:18:47.662 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.94913 2.71195 -3.2199 │
└                         ┘
 
23:18:47.662 [info]  Input Vector  = #Matrex[1×2]
┌                 ┐
│ 3.39656 4.40029 │
└                 ┘ , Y = 0.0
 
23:18:47.662 [info]  W updates = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
23:18:47.662 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.94913 2.71195 -3.2199 │
└                         ┘
 
23:18:47.662 [info]  Input Vector  = #Matrex[1×2]
┌                 ┐
│ 1.38807 1.85022 │
└                 ┘ , Y = 0.0
 
23:18:47.662 [info]  W updates = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
23:18:47.662 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.94913 2.71195 -3.2199 │
└                         ┘
 
23:18:47.662 [info]  Input Vector  = #Matrex[1×2]
┌                 ┐
│ 3.06407 3.00531 │
└                 ┘ , Y = 0.0
 
23:18:47.663 [info]  W updates = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
23:18:47.663 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.94913 2.71195 -3.2199 │
└                         ┘
 
23:18:47.663 [info]  Input Vector  = #Matrex[1×2]
┌                 ┐
│ 7.62753 2.75926 │
└                 ┘ , Y = 1.0
 
23:18:47.663 [info]  W updates = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
23:18:47.663 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.94913 2.71195 -3.2199 │
└                         ┘
 
23:18:47.663 [info]  Input Vector  = #Matrex[1×2]
┌                 ┐
│ 5.33244 2.08863 │
└                 ┘ , Y = 1.0
 
23:18:47.663 [info]  W updates = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
23:18:47.663 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.94913 2.71195 -3.2199 │
└                         ┘
 
23:18:47.663 [info]  Input Vector  = #Matrex[1×2]
┌                 ┐
│  6.9226 1.77106 │
└                 ┘ , Y = 1.0
 
23:18:47.663 [info]  W updates = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
23:18:47.663 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.94913 2.71195 -3.2199 │
└                         ┘
 
23:18:47.663 [info]  Input Vector  = #Matrex[1×2]
┌                 ┐
│ 8.67542-0.24207 │
└                 ┘ , Y = 1.0
 
23:18:47.663 [info]  W updates = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
23:18:47.663 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.94913 2.71195 -3.2199 │
└                         ┘
 
23:18:47.663 [info]  Input Vector  = #Matrex[1×2]
┌                 ┐
│ 7.67376 3.50856 │
└                 ┘ , Y = 1.0
 
23:18:47.663 [info]  W updates = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
23:18:47.664 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.94913 2.71195 -3.2199 │
└                         ┘
 
23:18:47.664 [info]  Epoc = 5
 
23:18:47.667 [info]  layer = %Layer{errors: [#Matrex[1×1]
┌         ┐
│     0.0 │
└         ┘, #Matrex[1×1]
┌         ┐
│     0.0 │
└         ┘, #Matrex[1×1]
┌         ┐
│     0.0 │
└         ┘, #Matrex[1×1]
┌         ┐
│     0.0 │
└         ┘, #Matrex[1×1]
┌         ┐
│     0.0 │
└         ┘, #Matrex[1×1]
┌         ┐
│     0.0 │
└         ┘, #Matrex[1×1]
┌         ┐
│     0.0 │
└         ┘, #Matrex[1×1]
┌         ┐
│     0.0 │
└         ┘, #Matrex[1×1]
┌         ┐
│     0.0 │
└         ┘, #Matrex[1×1]
┌         ┐
│     0.0 │
└         ┘, #Matrex[1×1]
┌         ┐
│     0.0 │
└         ┘, #Matrex[1×1]
┌         ┐
│     0.0 │
└         ┘, #Matrex[1×1]
┌         ┐
│     0.0 │
└         ┘, #Matrex[1×1]
┌         ┐
│     0.0 │
└         ┘, #Matrex[1×1]
┌         ┐
│     0.0 │
└         ┘, #Matrex[1×1]
┌         ┐
│     0.0 │
└         ┘, #Matrex[1×1]
┌         ┐
│     0.0 │
└         ┘, #Matrex[1×1]
┌         ┐
│     0.0 │
└         ┘, #Matrex[1×1]
┌         ┐
│     0.0 │
└         ┘, #Matrex[1×1]
┌         ┐
│     0.0 │
└         ┘, #Matrex[1×1]
┌         ┐
│     0.0 │
└         ┘, #Matrex[1×1]
┌         ┐
│     0.0 │
└         ┘, #Matrex[1×1]
┌         ┐
│     0.0 │
└         ┘, #Matrex[1×1]
┌         ┐
│     0.0 │
└         ┘, #Matrex[1×1]
┌         ┐
│     0.0 │
└         ┘, #Matrex[1×1]
┌         ┐
│     0.0 │
└         ┘, #Matrex[1×1]
┌         ┐
│     0.0 │
└         ┘, #Matrex[1×1]
┌         ┐
│     0.0 │
└         ┘, #Matrex[1×1]
┌         ┐
│     0.0 │
└         ┘, #Matrex[1×1]
┌         ┐
│    -1.0 │
└         ┘, #Matrex[1×1]
┌         ┐
│     0.0 │
└         ┘, #Matrex[1×1]
┌         ┐
│     0.0 │
└         ┘, #Matrex[1×1]
┌         ┐
│     0.0 │
└         ┘, #Matrex[1×1]
┌         ┐
│     0.0 │
└         ┘, #Matrex[1×1]
┌         ┐
│     1.0 │
└         ┘, #Matrex[1×1]
┌         ┐
│     0.0 │
└         ┘, #Matrex[1×1]
┌         ┐
│     0.0 │
└         ┘, #Matrex[1×1]
┌         ┐
│    -1.0 │
└         ┘, #Matrex[1×1]
┌         ┐
│     0.0 │
└         ┘, #Matrex[1×1]
┌         ┐
│    -1.0 │
└         ┘, #Matrex[1×1]
┌         ┐
│     0.0 │
└         ┘, #Matrex[1×1]
┌         ┐
│     0.0 │
└         ┘, #Matrex[1×1]
┌         ┐
│     0.0 │
└         ┘, #Matrex[1×1]
┌         ┐
│     0.0 │
└         ┘, #Matrex[1×1]
┌         ┐
│     1.0 │
└         ┘, #Matrex[1×1]
┌         ┐
│     0.0 │
└         ┘, #Matrex[1×1]
┌         ┐
│     0.0 │
└         ┘, #Matrex[1×1]
┌         ┐
│     0.0 │
└         ┘, #Matrex[1×1]
┌         ┐
│     0.0 │
└         ┘, ...], eta: 0.5, field: #Matrex[1×3]
┌                         ┐
│     1.0     1.0     1.0 │
└                         ┘, name: :output_layer21, pid: #PID<0.199.0>, w: #Matrex[1×3]
┌                         ┐
│-0.94913 2.71195 -3.2199 │
└                         ┘}
:ok

```

### TODO The code will be tested against different data sets.


## Literature
* 
