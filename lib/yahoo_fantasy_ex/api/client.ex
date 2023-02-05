defmodule YahooFantasyEx.Api.Client do
  @moduledoc false

  @base_url "https://fantasysports.yahooapis.com/fantasy/v2"
  @params %{format: :json}

  alias YahooFantasyEx.Auth

  @spec get!(String.t()) :: map()
  def get!(path) do
    headers = %{Authorization: "Bearer #{Auth.get_access_token()}"}

    url = "#{@base_url}#{path}"

    %HTTPoison.Response{body: body} =
      http_client().get!(url, headers, params: @params, recv_timeout: 10_000)

    Poison.Parser.parse!(body)
  end

  defp http_client do
    Application.get_env(:yahoo_fantasy_ex, :http_client, HTTPoison)
  end
end
