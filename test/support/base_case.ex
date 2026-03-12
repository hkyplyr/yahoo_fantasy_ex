defmodule YahooFantasyEx.BaseCase do
  @moduledoc false
  use ExUnit.CaseTemplate

  defmacro __using__(_) do
    quote do
      use ExUnit.Case

      import YahooFantasyEx.BaseCase
    end
  end

  def load_fixture(file_name) do
    file_name
    |> load_json()
    |> Jason.decode!(keys: :atoms)
  end

  def load_json(file_name), do: File.read!("test/support/fixtures/#{file_name}")

  def setup_bypass(_ctx) do
    [
      base_bypass: Bypass.open(port: 7997),
      authorize_bypass: Bypass.open(port: 7998),
      token_bypass: Bypass.open(port: 7999)
    ]
  end

  def setup_tokens(ctx) do
    token_file = Path.join(System.tmp_dir!(), "tokens.json")
    Application.put_env(:yahoo_fantasy_ex, :token_file, token_file)
    Application.put_env(:yahoo_fantasy_ex, :token_module, YahooFantasyEx.Tokens.File)

    token_state = Map.get(ctx, :token_state, :valid)

    if token_state != :no_token do
      File.write!(token_file, tokens(token_state))
    end

    on_exit(fn -> File.rm!(token_file) end)
  end

  def tokens(:new), do: build_tokens(%{access_token: "new_token"})
  def tokens(:refreshed), do: build_tokens(%{access_token: "refreshed_token"})

  def tokens(:expired) do
    expires_by = DateTime.add(DateTime.utc_now(), -1, :hour)
    build_tokens(%{expires_by: expires_by})
  end

  def tokens(:valid) do
    expires_by = DateTime.add(DateTime.utc_now(), 500, :second)

    build_tokens(%{expires_by: expires_by})
  end

  defp build_tokens(attrs) do
    %{
      access_token: "access_token",
      refresh_token: "refresh_token",
      expires_in: 3600
    }
    |> Map.merge(attrs)
    |> Jason.encode!()
  end
end
