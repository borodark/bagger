defmodule Layers.LayerTest do
  use ExUnit.Case , async: true
  require Logger
  doctest Layers

  test "infer 1" do
    field = Matrex.new([[1,0,1]]) # starting field of w0
    b_input = Matrex.new([[1,1,1]]) # starting x0 with bias
    w =  Matrex.new([[1,1,1]])  # starting w0
    assert Matrex.new([[1]]) == Layers.Layer.infer(b_input, field, w)
  end

  test "infer vector 2x3" do
    # 2 inputs 3 outputs
    field = Matrex.new([[1,1,1]]) # starting field of w0
    input_v = Matrex.new([[1,1,1]]) # starting x0
    w =  Matrex.new([[1,1,1],[1,1,1],[1,1,1]])  # starting w0
    assert Matrex.new([[1,1,1]]) == Layers.Layer.infer(input_v, field, w)
  end

  test "infer vector 3x2" do
    # 3 inputs 2 outputs
    field = Matrex.new([[1,1,1,1]]) # starting field of w0
    input_v = Matrex.new([[1,1,1,1]]) # starting x0
    w =  Matrex.new([[1,1,1,1],[1,1,1,1]])  # starting w0
    assert Matrex.new([[1,1]]) == Layers.Layer.infer(input_v, field, w)
  end

  test "learn once 2x1" do
    input_field = Matrex.new([[1,0,1]]) # starting field of w0
    input_v = Matrex.new([[1,1,1]]) # starting x0 with bias
    w =  Matrex.new([[1,1,1]])  # starting w0
    expectedZ = Matrex.new([[1]])
    {updates, errorZ}  = Layers.Layer.learn_once(w, 0.1, input_v, input_field, expectedZ)
    assert Matrex.new([[0]]) == updates
    assert Matrex.new([[0]]) == errorZ
  end

  test "learn once 2x1 - 1 - 1" do
    input_field = Matrex.new([[1,1,1]]) # starting field of w0
    input_v = Matrex.new([[1,-1,-1]]) # starting x0 with bias
    w =  Matrex.new([[1,1,1]])  # starting w0
    expectedZ = Matrex.new([[0]])
    {updates, errorZ}  = Layers.Layer.learn_once(w, 0.1, input_v, input_field, expectedZ)
    assert Matrex.new([[0]]) == updates
    assert Matrex.new([[0]]) == errorZ
  end

  test "learn positive step 2x1   " do
    input_field = Matrex.new([[1,1,1]]) # starting field of w0
    input_v = Matrex.new([[1,-1,-1]]) # starting x0 with bias
    w =  Matrex.new([[1,1,1]])  # starting w0
    expectedZ = Matrex.new([[1]])
    {updates, errorZ}  = Layers.Layer.learn_once(w, 0.1, input_v, input_field, expectedZ)
    assert Matrex.new([[0.1]]) == updates
    assert Matrex.new([[1]]) == errorZ

  end

  test "learn negative step 2x1   " do
    input_field = Matrex.new([[1,1,1]]) # starting field of w0
    input_v = Matrex.new([[1,1,1]]) # starting x0 with bias
    w =  Matrex.new([[1,1,1]])  # starting w0
    expectedZ = Matrex.new([[0]])
    {updates, errorZ}  = Layers.Layer.learn_once(w, 0.1, input_v, input_field, expectedZ)
    assert Matrex.new([[-0.1]]) == updates
    assert Matrex.new([[-1]]) == errorZ
  end

  test "learn 3x2 no step" do
    # 3 inputs 2 outputs
    field = Matrex.new([[1,1,1,1]]) # starting field of w0
    input_v = Matrex.new([[1,1,1,1]]) # starting x0 with bias
    w =  Matrex.new([[1,1,1,1],[1,1,1,1]])  # starting w0
    expectedZ = Matrex.new([[1,1]]) # 2 outputs
    {updates, errorZ}  = Layers.Layer.learn_once(w, 0.1, input_v, field, expectedZ)
    assert Matrex.new([[0, 0]]) == updates
    assert Matrex.new([[0, 0]]) == errorZ
  end

  test "learn 3x2 positive step" do
    # 3 inputs 2 outputs
    field = Matrex.new([[1,1,1,1]]) # starting field of w0
    input_v = Matrex.new([[1,-1,-1,-1]]) # starting x0 with bias
    w =  Matrex.new([[1,1,1,1],[1,1,1,1]])  # starting w0
    expectedZ = Matrex.new([[1,1]]) # 2 outputs
    {updates, errorZ}  = Layers.Layer.learn_once(w, 0.1, input_v, field, expectedZ)
    assert Matrex.new([[0.1, 0.1]]) == updates
    assert Matrex.new([[1,1]]) == errorZ
  end

  test "learn 3x2 negative step" do
    # 3 inputs 2 outputs
    field = Matrex.new([[1,1,1,1]]) # starting field of w0
    input_v = Matrex.new([[1,10,33,22]]) # starting x0 with bias
    w =  Matrex.new([[1,1,1,1],[1,1,1,1]])  # starting w0
    expectedZ = Matrex.new([[0,0]]) # 2 outputs
    {updates, errorZ}  = Layers.Layer.learn_once(w, 0.1, input_v, field, expectedZ)
    assert Matrex.new([[-0.1, -0.1]]) == updates
    assert Matrex.new([[-1,-1]]) == errorZ
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
