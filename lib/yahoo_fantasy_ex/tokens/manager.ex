defmodule YahooFantasyEx.Tokens.Manager do
  @moduledoc false
  @callback read :: {:ok, binary()} | {:error, atom()}
  @callback write(value :: String.t()) :: :ok
end
