defmodule CelloTest do
  use ExUnit.Case
  doctest Cello

  test "greets the world" do
    assert Cello.hello() == :world
  end
end
