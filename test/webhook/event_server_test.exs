defmodule Hipbrew.Webhook.EventServerTest do
  use ExUnit.Case

  setup do
    Hipbrew.Webhook.EventServer.start_link()
    :ok
  end

  test "event notify" do
    assert false
  end
end
