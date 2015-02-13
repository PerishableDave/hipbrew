defmodule Hipbrew.Room do
  import Hipbrew.Config, only: [api_url: 0]

  def list_rooms(api_token) do
    "#{api_url}/room"
      |> url_with_auth(api_token)
      |> HTTPoison.get
      |> handle_response
  end

  def room_history(room_id, api_token) do
    "#{api_url}/room/#{room_id}/history/latest"
      |> url_with_auth(api_token)
      |> HTTPoison.get
      |> handle_response
  end

  def send_message(room_id, message, api_token) do
    body = Poison.encode!(%{message: message, message_format: "text"})
    header = %{"Content-Type": "application/json"}

    "#{api_url}/room/#{room_id}/notification"
      |> url_with_auth(api_token)
      |> HTTPoison.post(body, header)
      |> handle_response
  end

  def create_webhook(room_id, url, event, api_token, options \\ []) do
    header = %{"Content-Type": "application/json"}
    body = %{url: url, event: event}
      |> Dict.merge(options)
      |> Poison.encode!

    "#{api_url}/room/#{room_id}/webook"
      |> url_with_auth(api_token)
      |> HTTPoison.post(body, header)
      |> handle_response
  end

  defp handle_response({:ok, %{status_code: 204}}) do
    :ok
  end

  defp handle_response({:ok, %{status_code: 200, body: body}}) do
    response = Poison.decode!(body)
    {:ok, response}
  end

  defp handle_response({:error, message}) do
    {:ok, message}
  end

  defp url_with_auth(url, api_token) do
    "#{url}?auth_token=#{api_token}"
  end
end
