# HW 1 

## Choice #1: Implementation of a Perceptron NetworkThis Project is for Educational Purposes Only

The programm is implemented in [`Elixir`](https://elixir-lang.org/) language
Please refer to [install guide](https://elixir-lang.org/install.html)
Clone this repo and `cd` to 

```Elixir
  #after cloning
  mix deps.get
  #start console
  iex -S mix
```
The entry point into the project is...

```Elixir
  Layer.train(10, :output_layer21)
```

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

```Elixir

iex(4)> Layer.train(5, :output_layer21) 

22:44:06.119 [info]  iv = #Matrex[1×2]
┌                 ┐
│ 2.78108 2.55054 │
└                 ┘ , Y = 0.0
 
22:44:06.119 [info]  w_u = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
22:44:06.119 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.68418 3.60714-3.94601 │
└                         ┘
 
22:44:06.119 [info]  iv = #Matrex[1×2]
┌                 ┐
│ 1.46549 2.36213 │
└                 ┘ , Y = 0.0
 
22:44:06.119 [info]  w_u = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
22:44:06.120 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.68418 3.60714-3.94601 │
└                         ┘
 
22:44:06.120 [info]  iv = #Matrex[1×2]
┌                 ┐
│ 3.39656 4.40029 │
└                 ┘ , Y = 0.0
 
22:44:06.120 [info]  w_u = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
22:44:06.120 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.68418 3.60714-3.94601 │
└                         ┘
 
22:44:06.120 [info]  iv = #Matrex[1×2]
┌                 ┐
│ 1.38807 1.85022 │
└                 ┘ , Y = 0.0
 
22:44:06.120 [info]  w_u = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
22:44:06.120 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.68418 3.60714-3.94601 │
└                         ┘
 
22:44:06.121 [info]  iv = #Matrex[1×2]
┌                 ┐
│ 3.06407 3.00531 │
└                 ┘ , Y = 0.0
 
22:44:06.121 [info]  w_u = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
22:44:06.121 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.68418 3.60714-3.94601 │
└                         ┘
 
22:44:06.121 [info]  iv = #Matrex[1×2]
┌                 ┐
│ 7.62753 2.75926 │
└                 ┘ , Y = 1.0
 
22:44:06.121 [info]  w_u = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
22:44:06.121 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.68418 3.60714-3.94601 │
└                         ┘
 
22:44:06.121 [info]  iv = #Matrex[1×2]
┌                 ┐
│ 5.33244 2.08863 │
└                 ┘ , Y = 1.0
 
22:44:06.121 [info]  w_u = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
22:44:06.121 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.68418 3.60714-3.94601 │
└                         ┘
 
22:44:06.122 [info]  iv = #Matrex[1×2]
┌                 ┐
│  6.9226 1.77106 │
└                 ┘ , Y = 1.0
 
22:44:06.122 [info]  w_u = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
22:44:06.122 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.68418 3.60714-3.94601 │
└                         ┘
 
22:44:06.122 [info]  iv = #Matrex[1×2]
┌                 ┐
│ 8.67542-0.24207 │
└                 ┘ , Y = 1.0
 
22:44:06.122 [info]  w_u = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
22:44:06.122 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.68418 3.60714-3.94601 │
└                         ┘
 
22:44:06.122 [info]  iv = #Matrex[1×2]
┌                 ┐
│ 7.67376 3.50856 │
└                 ┘ , Y = 1.0
 
22:44:06.122 [info]  w_u = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘

22:44:06.122 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.68418 3.60714-3.94601 │
└                         ┘
 
22:44:06.123 [info]  Epoc = 1

22:44:06.123 [info]  iv = #Matrex[1×2]
┌                 ┐
│ 2.78108 2.55054 │
└                 ┘ , Y = 0.0
 
22:44:06.123 [info]  w_u = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘

22:44:06.123 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.68418 3.60714-3.94601 │
└                         ┘

22:44:06.123 [info]  iv = #Matrex[1×2]
┌                 ┐
│ 1.46549 2.36213 │
└                 ┘ , Y = 0.0
 
22:44:06.123 [info]  w_u = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘

22:44:06.123 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.68418 3.60714-3.94601 │
└                         ┘
 
22:44:06.123 [info]  iv = #Matrex[1×2]
┌                 ┐
│ 3.39656 4.40029 │
└                 ┘ , Y = 0.0
 
22:44:06.124 [info]  w_u = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
22:44:06.124 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.68418 3.60714-3.94601 │
└                         ┘
 
22:44:06.124 [info]  iv = #Matrex[1×2]
┌                 ┐
│ 1.38807 1.85022 │
└                 ┘ , Y = 0.0
 
22:44:06.124 [info]  w_u = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
22:44:06.124 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.68418 3.60714-3.94601 │
└                         ┘
 
22:44:06.124 [info]  iv = #Matrex[1×2]
┌                 ┐
│ 3.06407 3.00531 │
└                 ┘ , Y = 0.0
 
22:44:06.124 [info]  w_u = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
22:44:06.124 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.68418 3.60714-3.94601 │
└                         ┘
 
22:44:06.124 [info]  iv = #Matrex[1×2]
┌                 ┐
│ 7.62753 2.75926 │
└                 ┘ , Y = 1.0
 
22:44:06.124 [info]  w_u = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
22:44:06.125 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.68418 3.60714-3.94601 │
└                         ┘
 
22:44:06.125 [info]  iv = #Matrex[1×2]
┌                 ┐
│ 5.33244 2.08863 │
└                 ┘ , Y = 1.0
 
22:44:06.125 [info]  w_u = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
22:44:06.125 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.68418 3.60714-3.94601 │
└                         ┘
 
22:44:06.125 [info]  iv = #Matrex[1×2]
┌                 ┐
│  6.9226 1.77106 │
└                 ┘ , Y = 1.0
 
22:44:06.125 [info]  w_u = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
22:44:06.125 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.68418 3.60714-3.94601 │
└                         ┘
 
22:44:06.125 [info]  iv = #Matrex[1×2]
┌                 ┐
│ 8.67542-0.24207 │
└                 ┘ , Y = 1.0
 
22:44:06.125 [info]  w_u = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
22:44:06.125 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.68418 3.60714-3.94601 │
└                         ┘
 
22:44:06.125 [info]  iv = #Matrex[1×2]
┌                 ┐
│ 7.67376 3.50856 │
└                 ┘ , Y = 1.0
 
22:44:06.125 [info]  w_u = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
22:44:06.125 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.68418 3.60714-3.94601 │
└                         ┘
 
22:44:06.126 [info]  Epoc = 2
 
22:44:06.126 [info]  iv = #Matrex[1×2]
┌                 ┐
│ 2.78108 2.55054 │
└                 ┘ , Y = 0.0
 
22:44:06.126 [info]  w_u = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
22:44:06.126 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.68418 3.60714-3.94601 │
└                         ┘
 
22:44:06.126 [info]  iv = #Matrex[1×2]
┌                 ┐
│ 1.46549 2.36213 │
└                 ┘ , Y = 0.0
 
22:44:06.126 [info]  w_u = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
22:44:06.126 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.68418 3.60714-3.94601 │
└                         ┘
 
22:44:06.126 [info]  iv = #Matrex[1×2]
┌                 ┐
│ 3.39656 4.40029 │
└                 ┘ , Y = 0.0
 
22:44:06.126 [info]  w_u = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
22:44:06.126 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.68418 3.60714-3.94601 │
└                         ┘
 
22:44:06.126 [info]  iv = #Matrex[1×2]
┌                 ┐
│ 1.38807 1.85022 │
└                 ┘ , Y = 0.0
 
22:44:06.126 [info]  w_u = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
22:44:06.126 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.68418 3.60714-3.94601 │
└                         ┘
 
22:44:06.127 [info]  iv = #Matrex[1×2]
┌                 ┐
│ 3.06407 3.00531 │
└                 ┘ , Y = 0.0
 
22:44:06.127 [info]  w_u = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
22:44:06.127 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.68418 3.60714-3.94601 │
└                         ┘
 
22:44:06.127 [info]  iv = #Matrex[1×2]
┌                 ┐
│ 7.62753 2.75926 │
└                 ┘ , Y = 1.0
 
22:44:06.127 [info]  w_u = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
22:44:06.127 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.68418 3.60714-3.94601 │
└                         ┘
 
22:44:06.127 [info]  iv = #Matrex[1×2]
┌                 ┐
│ 5.33244 2.08863 │
└                 ┘ , Y = 1.0
 
22:44:06.127 [info]  w_u = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
22:44:06.127 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.68418 3.60714-3.94601 │
└                         ┘
 
22:44:06.127 [info]  iv = #Matrex[1×2]
┌                 ┐
│  6.9226 1.77106 │
└                 ┘ , Y = 1.0
 
22:44:06.127 [info]  w_u = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
22:44:06.127 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.68418 3.60714-3.94601 │
└                         ┘
 
22:44:06.127 [info]  iv = #Matrex[1×2]
┌                 ┐
│ 8.67542-0.24207 │
└                 ┘ , Y = 1.0
 
22:44:06.127 [info]  w_u = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
22:44:06.128 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.68418 3.60714-3.94601 │
└                         ┘
 
22:44:06.128 [info]  iv = #Matrex[1×2]
┌                 ┐
│ 7.67376 3.50856 │
└                 ┘ , Y = 1.0
 
22:44:06.128 [info]  w_u = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
22:44:06.128 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.68418 3.60714-3.94601 │
└                         ┘
 
22:44:06.128 [info]  Epoc = 3
 
22:44:06.128 [info]  iv = #Matrex[1×2]
┌                 ┐
│ 2.78108 2.55054 │
└                 ┘ , Y = 0.0
 
22:44:06.128 [info]  w_u = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
22:44:06.128 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.68418 3.60714-3.94601 │
└                         ┘
 
22:44:06.128 [info]  iv = #Matrex[1×2]
┌                 ┐
│ 1.46549 2.36213 │
└                 ┘ , Y = 0.0
 
22:44:06.128 [info]  w_u = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
22:44:06.128 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.68418 3.60714-3.94601 │
└                         ┘
 
22:44:06.128 [info]  iv = #Matrex[1×2]
┌                 ┐
│ 3.39656 4.40029 │
└                 ┘ , Y = 0.0
 
22:44:06.128 [info]  w_u = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
22:44:06.128 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.68418 3.60714-3.94601 │
└                         ┘
 
22:44:06.129 [info]  iv = #Matrex[1×2]
┌                 ┐
│ 1.38807 1.85022 │
└                 ┘ , Y = 0.0
 
22:44:06.129 [info]  w_u = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
22:44:06.129 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.68418 3.60714-3.94601 │
└                         ┘
 
22:44:06.129 [info]  iv = #Matrex[1×2]
┌                 ┐
│ 3.06407 3.00531 │
└                 ┘ , Y = 0.0
 
22:44:06.129 [info]  w_u = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
22:44:06.129 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.68418 3.60714-3.94601 │
└                         ┘
 
22:44:06.129 [info]  iv = #Matrex[1×2]
┌                 ┐
│ 7.62753 2.75926 │
└                 ┘ , Y = 1.0
 
22:44:06.129 [info]  w_u = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
22:44:06.129 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.68418 3.60714-3.94601 │
└                         ┘
 
22:44:06.129 [info]  iv = #Matrex[1×2]
┌                 ┐
│ 5.33244 2.08863 │
└                 ┘ , Y = 1.0
 
22:44:06.129 [info]  w_u = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
22:44:06.129 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.68418 3.60714-3.94601 │
└                         ┘
 
22:44:06.129 [info]  iv = #Matrex[1×2]
┌                 ┐
│  6.9226 1.77106 │
└                 ┘ , Y = 1.0
 
22:44:06.129 [info]  w_u = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
22:44:06.130 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.68418 3.60714-3.94601 │
└                         ┘
 
22:44:06.130 [info]  iv = #Matrex[1×2]
┌                 ┐
│ 8.67542-0.24207 │
└                 ┘ , Y = 1.0
 
22:44:06.130 [info]  w_u = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
22:44:06.130 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.68418 3.60714-3.94601 │
└                         ┘
 
22:44:06.130 [info]  iv = #Matrex[1×2]
┌                 ┐
│ 7.67376 3.50856 │
└                 ┘ , Y = 1.0
 
22:44:06.130 [info]  w_u = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
22:44:06.130 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.68418 3.60714-3.94601 │
└                         ┘
 
22:44:06.130 [info]  Epoc = 4
 
22:44:06.130 [info]  iv = #Matrex[1×2]
┌                 ┐
│ 2.78108 2.55054 │
└                 ┘ , Y = 0.0
 
22:44:06.130 [info]  w_u = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
22:44:06.130 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.68418 3.60714-3.94601 │
└                         ┘
 
22:44:06.130 [info]  iv = #Matrex[1×2]
┌                 ┐
│ 1.46549 2.36213 │
└                 ┘ , Y = 0.0
 
22:44:06.130 [info]  w_u = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
22:44:06.131 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.68418 3.60714-3.94601 │
└                         ┘
 
22:44:06.131 [info]  iv = #Matrex[1×2]
┌                 ┐
│ 3.39656 4.40029 │
└                 ┘ , Y = 0.0
 
22:44:06.131 [info]  w_u = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
22:44:06.131 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.68418 3.60714-3.94601 │
└                         ┘
 
22:44:06.131 [info]  iv = #Matrex[1×2]
┌                 ┐
│ 1.38807 1.85022 │
└                 ┘ , Y = 0.0
 
22:44:06.131 [info]  w_u = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
22:44:06.131 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.68418 3.60714-3.94601 │
└                         ┘
 
22:44:06.131 [info]  iv = #Matrex[1×2]
┌                 ┐
│ 3.06407 3.00531 │
└                 ┘ , Y = 0.0
 
22:44:06.131 [info]  w_u = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
22:44:06.131 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.68418 3.60714-3.94601 │
└                         ┘
 
22:44:06.131 [info]  iv = #Matrex[1×2]
┌                 ┐
│ 7.62753 2.75926 │
└                 ┘ , Y = 1.0
 
22:44:06.131 [info]  w_u = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
22:44:06.131 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.68418 3.60714-3.94601 │
└                         ┘
 
22:44:06.131 [info]  iv = #Matrex[1×2]
┌                 ┐
│ 5.33244 2.08863 │
└                 ┘ , Y = 1.0
 
22:44:06.132 [info]  w_u = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
22:44:06.132 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.68418 3.60714-3.94601 │
└                         ┘
 
22:44:06.132 [info]  iv = #Matrex[1×2]
┌                 ┐
│  6.9226 1.77106 │
└                 ┘ , Y = 1.0
 
22:44:06.132 [info]  w_u = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
22:44:06.132 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.68418 3.60714-3.94601 │
└                         ┘
 
22:44:06.132 [info]  iv = #Matrex[1×2]
┌                 ┐
│ 8.67542-0.24207 │
└                 ┘ , Y = 1.0
 
22:44:06.132 [info]  w_u = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
22:44:06.132 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.68418 3.60714-3.94601 │
└                         ┘
 
22:44:06.132 [info]  iv = #Matrex[1×2]
┌                 ┐
│ 7.67376 3.50856 │
└                 ┘ , Y = 1.0
 
22:44:06.132 [info]  w_u = #Matrex[1×3]
┌                         ┐
│     0.0     0.0     0.0 │
└                         ┘
 
22:44:06.132 [info]  new W = #Matrex[1×3]
┌                         ┐
│-0.68418 3.60714-3.94601 │
└                         ┘
 
22:44:06.132 [info]  Epoc = 5
 
22:44:06.133 [info]  layer = %Layer{errors: [#Matrex[1×1]
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
└         ┘, ...], eta: 0.5, field: #Matrex[1×3]
┌                         ┐
│     1.0     1.0     1.0 │
└                         ┘, name: :output_layer21, pid: #PID<0.190.0>, w: #Matrex[1×3]
┌                         ┐
│-0.68418 3.60714-3.94601 │
└                         ┘}

```

### TODO The code will be tested against different data sets.


## Literature
* 
