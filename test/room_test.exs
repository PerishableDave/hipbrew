defmodule RoomTests do
  use ExUnit.Case, async: false
  import Mock

  @api_token "abcdef"

  @list_room_response """
  {
    "items": [
      {
        "id": 1,
        "links": {
          "members": "https://api.hipchat.com/v2/room/1/member",
          "participants": "https://api.hipchat.com/v2/room/1/participant",
          "self": "https://api.hipchat.com/v2/room/1",
          "webhooks": "https://api.hipchat.com/v2/room/1/webhook"
        },
        "name": "Test A"
      },
      {
        "id": 2,
        "links": {
          "participants": "https://api.hipchat.com/v2/room/2/participant",
          "self": "https://api.hipchat.com/v2/room/2",
          "webhooks": "https://api.hipchat.com/v2/room/2/webhook"
        },
        "name": "Test B"
      }
    ],
    "links": {
      "self": "https://api.hipchat.com/v2/room"
    },
    "maxResults": 100,
    "startIndex": 0
  }
  """

  @room_history_response """
  {
    "items": [
      {
        "date": "2015-02-06T22:12:01.370035+00:00",
        "from": {
          "id": 1,
          "links": {
            "self": "https://api.hipchat.com/v2/user/11"
          },
          "mention_name": "leo",
          "name": "Leonardo "
        },
        "id": "747f3137-84bb-4679-bb24-0cfdba98559e",
        "mentions": [],
        "message": "pizza time",
        "type": "message"
      },
      {
        "date": "2015-02-06T22:18:19.540091+00:00",
        "from": {
          "id": 2,
          "links": {
            "self": "https://api.hipchat.com/v2/user/22"
          },
          "mention_name": "raf",
          "name": "Raphael"
        },
        "id": "977331b8-a9ed-4cd9-a82e-d7d62c9329b0",
        "mentions": [],
        "message": "shell shock",
        "type": "message"
      }
    ],
    "links": {
      "self": "https://api.hipchat.com/v2/room/1105590/history/latest"
    },
    "maxResults": 75,
    "startIndex": 0
  }
  """

  test "list rooms" do
    with_mock HTTPoison, [get: fn(_url) ->
      {:ok, %{status_code: 200, body: @list_room_response}}
    end] do
      {response, %{"items" => items}} = Hipbrew.Room.list_rooms(@api_token)
      assert response == :ok
      assert length(items) == 2
    end
  end

  test "room history" do
    with_mock HTTPoison, [get: fn(_url) ->
        {:ok, %{status_code: 200, body: @room_history_response}}
    end] do
      {response, %{"items" => items}} = Hipbrew.Room.room_history(1, @api_token)
      assert response == :ok
      assert length(items) == 2
    end
  end
end
