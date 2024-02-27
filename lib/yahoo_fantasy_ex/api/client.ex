defmodule YahooFantasyEx.Api.Client do
  @moduledoc false

  @params %{format: :json}

  alias YahooFantasyEx.Auth

  @spec get!(String.t()) :: map()
  def get!(path) do
    headers = %{Authorization: "Bearer #{Auth.get_access_token()}"}

    url = "#{base_url()}#{path}"

    %Req.Response{body: body} =
      Req.get!(
        url: url,
        headers: headers,
        params: @params,
        http_errors: :raise,
        decode_json: [keys: :atoms]
      )

    body
  end

  defp base_url, do: Application.get_env(:yahoo_fantasy_ex, :base_url)
end
