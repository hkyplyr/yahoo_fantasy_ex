defmodule YahooFantasyEx.Auth do
  @moduledoc false

  import HTTPoison

  @authorize_url "https://api.login.yahoo.com/oauth2/request_auth"
  @token_url "https://api.login.yahoo.com/oauth2/get_token"

  defp client_id, do: System.get_env("CLIENT_ID")
  defp client_secret, do: System.get_env("CLIENT_SECRET")

  @doc """
  Retrieves the access token to include in the request.

  ## Examples

      iex> YahooFantasyEx.Auth.get_access_token()
      "access_token"
  """
  @spec get_access_token :: String.t()
  def get_access_token do
    case token_manager().read() do
      {:ok, binary} ->
        %{
          "access_token" => access_token,
          "refresh_token" => refresh_token,
          "expires_by" => expires_by
        } = Poison.decode!(binary)

        if DateTime.to_unix(DateTime.utc_now()) > expires_by - 300 do
          refresh_tokens(refresh_token)
        else
          access_token
        end

      {:error, :enoent} ->
        code = get_auth_code()

        data = [
          {:client_id, client_id()},
          {:client_secret, client_secret()},
          {:redirect_uri, :oob},
          {:code, code},
          {:grant_type, :authorization_code}
        ]

        %HTTPoison.Response{body: body} = http_client().post!(@token_url, {:form, data})

        updated =
          body
          |> Poison.decode!()
          |> put_expires_by()

        token_manager().write(updated)

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

    %HTTPoison.Response{body: body} = http_client().post!(@token_url, {:form, data})

    updated =
      body
      |> Poison.decode!()
      |> put_expires_by()

    token_manager().write(updated)

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

  defp get_location(params, headers) do
    @authorize_url
    |> get!(headers, params: params)
    |> Map.get(:headers)
    |> Enum.find(&find_location/1)
    |> elem(1)
    |> io().puts()
  end

  defp find_location({k, _}), do: k == "Location"

  defp put_expires_by(%{"expires_in" => expires_in} = token_response) do
    expires_by =
      DateTime.utc_now()
      |> DateTime.to_unix()
      |> Kernel.+(expires_in)

    Map.put(token_response, "expires_by", expires_by)
  end

  defp io do
    Application.get_env(:yahoo_fantasy_ex, :io, IO)
  end

  defp http_client do
    Application.get_env(:yahoo_fantasy_ex, :http_client, HTTPoison)
  end

  defp token_manager do
    Application.get_env(:yahoo_fantasy_ex, :token_manager, YahooFantasyEx.Tokens.File)
  end
end
