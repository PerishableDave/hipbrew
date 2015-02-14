defmodule Hipbrew.Request do
  @api_url "https://api.hipchat.com/v2"

  def get(path, params \\ []) do
    url(path, params)
      |> HTTPoison.get
      |> handle_response
  end

  def post(path, params, query_params \\ []) do
    header = %{"Content-Type": "application/json"}
    body = Poison.encode!(params)
    url(path, query_params)
      |> HTTPoison.post(body, header)
      |> handle_response
  end

  def url(path, query_params \\ []) do
    query = URI.encode_query(query_params)
    "#{@api_url}#{path}?#{query}"
  end

  defp handle_response({:ok, %{status_code: 204}}) do
    :ok
  end

  defp handle_response({:ok, %{status_code: 200, body: body}}) do
    Poison.decode(body)
  end

  defp handle_response({:error, message}) do
    {:ok, message}
  end
end
