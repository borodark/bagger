defmodule Layers.LayerTest do
  use ExUnit.Case , async: true
  import Layers.Layer 
  import Matrex
  doctest Layers

  test "infer 1" do
    field = Matrex.new([[1,0,1]]) # starting field of w0
    input_v = Matrex.new([[1,1]]) # starting x1
    w =  Matrex.new([[1,1,1]])  # starting w0
    assert Matrex.new([[1]]) == Layers.Layer.infer(input_v, field, w)
  end

  test "infer vector 2x3" do
    # 2 inputs 3 outputs
    field = Matrex.new([[1,1,1]]) # starting field of w0
    input_v = Matrex.new([[1,1]]) # starting x1
    w =  Matrex.new([[1,1,1],[1,1,1],[1,1,1]])  # starting w0
    assert Matrex.new([[1,1,1]]) == Layers.Layer.infer(input_v, field, w)
  end
  test "infer vector 3x2" do
    # 3 inputs 2 outputs
    field = Matrex.new([[1,1,1,1]]) # starting field of w0
    input_v = Matrex.new([[1,1,1]]) # starting x1
    w =  Matrex.new([[1,1,1,1],[1,1,1,1]])  # starting w0
    assert Matrex.new([[1,1]]) == Layers.Layer.infer(input_v, field, w)
  end

  test "learn once single" do
    assert 1 == 1
    # TODO
  end

  test "learn once vector" do
    assert 1 == 1
    # TODO
  end

  test "test hard limit single" do
    activations = Matrex.new([[1,1,1,1,1]])
    assert activations == Layers.Layer.hard_limit(activations)
  end

  test "test hard limit" do
    activations = Matrex.new([[0.1,1,0.1,1,0.1]])
    expected = Matrex.new([[1,1,1,1,1]])
    assert expected == Layers.Layer.hard_limit(activations)
  end
end
