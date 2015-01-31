defmodule Hipbrew do
  use Application

  def start(_type, _args) do

    token = Application.get_env(:hipbrew, :token)
    if token == nil do
      raise("Set Hipchat API token in your config file.")
    end

    Hipbrew.Supervisor.start_link(token)
  end
end
