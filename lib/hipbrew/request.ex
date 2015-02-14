defmodule Hipbrew.Request do
  @api_url "https://api.hipchat.com/v2"

  def get(path, params \\ []) do
    url(path, params) |> HTTPoison.get
  end

  def post(path, params, query_params \\ []) do
    header = %{"Content-Type": "application/json"}
    body = Poison.encode!(params)
    url(path, query_params) |> HTTPoison.post(body, header)
  end

  def url(path, query_params \\ []) do
    query = URI.encode_query(query_params)
    "#{@api_url}#{path}?#{query}"
  end
end
