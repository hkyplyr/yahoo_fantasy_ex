defmodule YahooFantasyEx.Models.TransactionTest do
  use YahooFantasyEx.BaseCase

  alias YahooFantasyEx.Models.Transaction

  describe "new/1" do
    test "returns the list of transactions with valid data" do
      json = load_fixture("league/transactions.json")

      assert [%{}, %{}] = Enum.map(json[:fantasy_content][:league], &Transaction.new/1)
    end
  end
end
