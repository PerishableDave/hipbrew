defmodule Hipbrew.CliTests do
  use ExUnit.Case

  import Hipbrew.CLI, only: [parse_args: 1]

  test ":help returned by option parsing --help" do
    assert parse_args(["--help", "anything"]) == :help
  end
end
