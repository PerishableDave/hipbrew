defmodule Hipbrew.Room do
  import Hipbrew.Request

  def list_rooms(api_token) do
    "/room"
      |> get(%{api_token: api_token})
  end

  def room_history(room_id, api_token) do
    "/room/#{room_id}/history/latest"
      |> get(%{api_token: api_token})
  end

  def send_message(room_id, message, api_token) do
    params = %{message: message, message_format: "text"}

    "/room/#{room_id}/notification"
      |> post(params, %{api_token: api_token})
  end

  def create_webhook(room_id, url, event, api_token, options \\ []) do
    params = %{url: url, event: event}

    "/room/#{room_id}/webook"
      |> post(params, %{api_token: api_token})
  end

end
