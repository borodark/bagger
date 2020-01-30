defmodule Layers.LayerTest do
  use ExUnit.Case , async: true
  import Layers.Layer
  import Matrex
  doctest Layers

  test "infer 1" do
    assert 1 == 1
    # TODO
  end

  test "infer vector" do
    assert 1 == 1
    # TODO
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

  test "test hard limit multiple categories" do
    activations = Matrex.new([[0,1,0,1,0]])
    assert activations == Layers.Layer.hard_limit(activations)
  end
end
