defmodule Hipbrew.Room do
  @api_url "https://api.hipchat.com/v2"

  defstruct id: nil, name: nil, links: %{}

  def list_rooms(api_token) do
    "#{@api_url}/room?auth_token=#{api_token}"
      |> HTTPoison.get
      |> handle_response
  end

  def room_history(room_id, api_token) do
    "#{@api_url}/room/#{room_id}/history/latest?auth_token=#{api_token}"
      |> HTTPoison.get
      |> handle_response
  end

  def handle_response({:ok, %{status_code: 200, body: body}}) do
    Poison.decode!(body)
  end

  def handle_response({:error, message}) do
    {:error, message}
  end
end
