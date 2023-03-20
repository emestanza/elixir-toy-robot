defmodule ToyRobot.Game.PlayerSupervisorTest do
  use ExUnit.Case, async: true

  alias ToyRobot.{Game.PlayerSupervisor, Robot}
  alias ToyRobot.Table

  def build_table do
    %Table{
      north_boundary: 4,
      east_boundary: 4
    }
  end

  test "starts a game child process" do
    starting_position = %{noth: 0, east: 0, facing: :north}

    {:ok, player} =
      PlayerSupervisor.start_child(
        build_table(),
        starting_position,
        "Izzy"
      )

    [{registered_player, _}] = Registry.lookup(
        ToyRobot.Game.PlayerRegistry,
        "Izzy"
      )

    assert registered_player == player
  end

  test "starts a registry" do
    registry = Process.whereis(ToyRobot.Game.PlayerRegistry)
    assert registry
  end

  test "moves a robot forward" do
    starting_position = %{north: 0, east: 0, facing: :north}

    {:ok, _player} =
      PlayerSupervisor.start_child(
        build_table(),
        starting_position,
        "Charlie"
      )

    :ok = PlayerSupervisor.move("Charlie")
    %{north: north} = PlayerSupervisor.report("Charlie")
    assert north == 1
  end

  test "reports a robot's location" do
    starting_position = %{north: 0, east: 0, facing: :north}

    {:ok, _player} =
      PlayerSupervisor.start_child(
        build_table(),
        starting_position,
        "Davros"
      )

    %{north: north} = PlayerSupervisor.report("Davros")

    assert north == 0
  end
end
