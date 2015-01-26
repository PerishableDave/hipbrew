defmodule Hipbrew.CLI do
  def run(argv) do
    argv
     |> parse_args
     |> process
  end

  def parse_args(argv) do
    parse = OptionParser.parse(argv,
      switches: [help: :boolean],
      aliases: [h: :help])

    case parse do
      {[help: true], _, _} -> :help
      {[token: token], ["rooms"], _} -> {:rooms, token}
    end
  end

  def process(:help) do

  end

  def process({:rooms, token}) do
    Hipbrew.Room.list(token)
  end
end
