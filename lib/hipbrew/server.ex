defmodule Hipbrew.Server do
  alias Hipbrew.Room

  use GenServer

  def start_link(api_token) do
    GenServer.start_link(__MODULE__, api_token, name: __MODULE__)
  end

  def list_rooms do
    GenServer.call __MODULE__, :list_rooms
  end

  def room_history(room_id) do
    GenServer.call __MODULE__, {:room_history, room_id}
  end

  def send_message(room_id, message) do
    GenServer.cast __MODULE__, {:send_message, room_id, message}
  end

  def handle_call(:list_rooms, _, api_token) do
    case Room.list_rooms(api_token) do
      {:ok, rooms} ->
        {:reply, rooms, api_token}
      error -> error
    end
  end

  def handle_call({:room_history, room_id}, _, api_token) do
    case Room.room_history(room_id, api_token) do
      {:ok, messages} ->
        {:reply, messages, api_token}
      error -> error
    end
  end

  def handle_cast({:send_message, room_id, message}, api_token) do
    Room.send_message(message, room_id, api_token)
    {:no_reply, api_token}
  end
end
