defmodule YahooFantasyEx.Auth do
  @moduledoc false

  alias YahooFantasyEx.Tokens

  @authorize_url "https://api.login.yahoo.com/oauth2/request_auth"
  @token_url "https://api.login.yahoo.com/oauth2/get_token"

  @doc """
  Retrieves the access token to include in the request.
  """
  @spec get_access_token :: String.t()
  def get_access_token do
    case Tokens.get() do
      {:ok, token} ->
        current_time_with_buffer = DateTime.add(DateTime.utc_now(), 300, :second)

        case DateTime.compare(current_time_with_buffer, token.expires_by) do
          :gt -> refresh_tokens(token.refresh_token)
          _lt -> token.access_token
        end

      :error ->
        code = get_auth_code()

        data = [
          {:client_id, client_id()},
          {:client_secret, client_secret()},
          {:redirect_uri, :oob},
          {:code, code},
          {:grant_type, :authorization_code}
        ]

        %Req.Response{body: body} = Req.post!(url: token_url(), form: data)

        updated = put_expires_by(body)

        Tokens.put(updated)

        Map.get(updated, "access_token")
    end
  end

  defp refresh_tokens(refresh_token) do
    data = [
      {:client_id, client_id()},
      {:client_secret, client_secret()},
      {:redirect_uri, :oob},
      {:refresh_token, refresh_token},
      {:grant_type, :refresh_token}
    ]

    %Req.Response{body: body} = Req.post!(url: token_url(), form: data)

    updated = put_expires_by(body)

    Tokens.put(updated)

    Map.get(updated, "access_token")
  end

  defp get_auth_code do
    headers = ["Content-Type": "application/json"]

    %{
      client_id: client_id(),
      client_secret: client_secret(),
      redirect_uri: :oob,
      response_type: :code
    }
    |> get_location(headers)

    "Code: "
    |> io().gets()
    |> String.trim()
  end

  defp get_location(params, request_headers) do
    %Req.Response{headers: response_headers} =
      Req.get!(url: authorize_url(), headers: request_headers, params: params)

    response_headers
    |> Enum.find_value(fn {k, v} -> if k == "location", do: v end)
    |> io().puts()
  end

  defp put_expires_by(%{"expires_in" => expires_in} = token_response) do
    expires_by =
      DateTime.utc_now()
      |> DateTime.to_unix()
      |> Kernel.+(expires_in)

    Map.put(token_response, "expires_by", expires_by)
  end

  defp io, do: Application.get_env(:yahoo_fantasy_ex, :io, IO)

  defp client_id, do: Application.fetch_env!(:yahoo_fantasy_ex, :client_id)
  defp client_secret, do: Application.fetch_env!(:yahoo_fantasy_ex, :client_secret)
  defp authorize_url, do: Application.get_env(:yahoo_fantasy_ex, :authorize_url, @authorize_url)
  defp token_url, do: Application.get_env(:yahoo_fantasy_ex, :token_url, @token_url)
end
