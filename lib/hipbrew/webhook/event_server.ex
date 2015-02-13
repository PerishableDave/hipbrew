defmodule Hipbrew.Webhook.EventServer do
  def start_link() do
    GenEvent.start_link(name: __MODULE__)
  end

  def notify_event(event) do
    event_type = String.to_atom(event["event"])
    GenEvent.notify(__MODULE__, {event_type, event})
  end
end
