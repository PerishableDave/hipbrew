defmodule Hipbrew.Room do
  import Hipbrew.Config, only: [api_url: 0]

  defstruct id: nil, name: nil, links: %{}

  def list_rooms(api_token) do
    "#{api_url}/room?auth_token=#{api_token}"
      |> HTTPoison.get
      |> handle_response
  end

  def room_history(room_id, api_token) do
    "#{api_url}/room/#{room_id}/history/latest?auth_token=#{api_token}"
      |> HTTPoison.get
      |> handle_response
  end

  def send_message(message, room_id, name, api_token) do
    #todo
  end

  defp handle_response({:ok, %{status_code: 200, body: body}}) do
    response = Poison.decode!(body)
    {:ok, response}
  end

  defp handle_response({:error, message}) do
    {:ok, message}
  end
end
