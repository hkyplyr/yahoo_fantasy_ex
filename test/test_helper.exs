ExUnit.start()

defmodule FakeIO do
  def gets("Code: "), do: "API Code"
  def puts(_), do: :ok
  def binwrite(_, _), do: :ok
end

Application.put_env(:yahoo_fantasy_ex, :io, FakeIO)
