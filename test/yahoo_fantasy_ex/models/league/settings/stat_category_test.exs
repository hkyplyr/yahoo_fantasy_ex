defmodule YahooFantasyEx.Models.League.Settings.StatCategoryTest do
  use YahooFantasyEx.ModelCase
  doctest YahooFantasyEx.Models.League.Settings.StatCategory
  alias YahooFantasyEx.Models.League.Settings.StatCategory

  describe "new/1" do
    test "returns a single stat category with valid data" do
      json = load_fixture("stat_category/stat_category.json")

      assert %StatCategory{
               abbr: "G",
               display_name: "G",
               enabled: true,
               group: :offense,
               name: "Goals",
               position_type: :player,
               sort_order: :desc,
               stat_id: 1
             } = StatCategory.new(json)
    end
  end
end
