defmodule Hipbrew.Supervisor do
  use Supervisor

  def start_link(api_token) do
    Supervisor.start_link(__MODULE__, api_token)
  end

  def init(api_token) do
    children = [
      worker(Hipbrew.Server, api_token),
      worker(Hipbrew.Webhook.EventServer, [])
    ]
    supervise(children, strategy: :one_for_one)
  end
end
