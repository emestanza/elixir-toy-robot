defmodule ToyRobot.Game.PlayerTest do
  use ExUnit.Case, async: true

  alias ToyRobot.Game.Player
  alias ToyRobot.Robot

  describe "report" do
    setup do
      starting_position = %Robot{north: 0, east: 0, facing: :north}
      {:ok, player} = Player.start(starting_position)
      %{player: player}
    end

    test "shows the current position of the robot", %{player: player} do
      assert Player.report(player) == %Robot{north: 0, east: 0, facing: :north}
    end
  end

  describe "move" do
    setup do
      starting_position = %Robot{north: 0, east: 0, facing: :north}
      {:ok, player} = Player.start(starting_position)
      %{player: player}
    end

    test "shows the current position of the robot", %{player: player} do
      Player.move(player)
      robot = Player.report(player)
      assert robot == %Robot{north: 1, east: 0, facing: :north}
    end
  end
end
