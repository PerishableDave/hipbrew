defmodule Hipbrew.Webhook.Plug do
  import Plug.Conn
  import Hipbrew.Webhook.EventServer, only: [notify_event: 1]

  def call(%Plug.Conn{} = conn, opts) do
    if full_path(conn) == opts[:path] and conn.method == "GET" do
      case parse(conn) do
        {:ok, event} ->
          notify_event(event)
      end
    else
      conn
    end
  end

  defp parse(conn) do
    case Plug.Conn.read_body(conn) do
      {:ok, body, conn} ->
        {:ok, Poison.decode!(body)}
      {:more, _data, conn} ->
        {:error, :too_large, conn}
    end
  end
end
