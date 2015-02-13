# Hipbrew

Hipchat client for Elixir.

## Installation

Add Hipbrew into mix.exs

```
def application do
  [applications: [:hipbrew]]
end

defp deps do
  [{:hipbrew, github: "perishabledave/hipbrew"}]
end
```

## Webhooks

Add the webhook plug to your server.

```
defmodule MyServer do
  use Plug.Builder
  plug Hipbrew.Webhook.Plug, path: "/webhook/hipchat"
end
```

Create a event handler.

```
defmodule MessageHandler do
  use GenEvent

  def handle_event({:room_notification, event}, []) do
    # Handle event
  end
end
```

And register the event handler

```
Hipbrew.Webhook.EventServer.add_handler(MessageHandler)
```
