defmodule Hipbrew.Webhook.PlugTests do
  use ExUnit.Case, async: true
  use Plug.Test

  @event_json """
  {
    "event": "room_message",
    "item": {}
  }
  """

  setup do
    {:ok, event_server} = Hipbrew.Webhook.EventServer.start_link
    :ok
  end

  test "webhook sends a event" do
    path = "/webhooks/hipchat"
    conn = conn(:post, path, @event_json, [headers: [{"content-type", "application/json"}]])

    conn = Hipbrew.Webhook.Plug.call(conn, %{path: path})
    assert conn.status == 204
  end
end
