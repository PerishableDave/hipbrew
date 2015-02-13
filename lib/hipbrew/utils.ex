defmodule Hipbrew.Utils do
  def get(path, params \\ []) do
    URI
    HTTPoison.get
  end

  def post(path, params) do

  end
end
