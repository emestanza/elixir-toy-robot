defmodule ToyRobot.CLITest do
  use ExUnit.Case, async: true

  import ExUnit.CaptureIO


  test "provides usage instructions if no arguments specified" do
    output = capture_io fn  ->
      ToyRobot.CLI.main([])
    end

    assert output |> String.trim == "Usage: toy_robot commands.txt"
  end
end
