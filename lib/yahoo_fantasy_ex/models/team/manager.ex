defmodule YahooFantasyEx.Models.Team.Manager do
  @moduledoc false
  use YahooFantasyEx.Model,
    fields: [
      felo_score: :integer,
      felo_tier: :atom,
      guid: :string,
      image_url: :string,
      manager_id: :integer,
      nickname: :string
    ]
end
