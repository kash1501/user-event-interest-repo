defmodule Seeds.Interest do
  alias UserEventInterest.Interests.Interest
  alias UserEventInterest.Repo

  @interest [
    %{
      name: "hockey",
      desc: "hockey_hockey"
    },
    %{
      name: "photography",
      desc: "photography_photography"
    },
    %{
      name: "pool",
      desc: "pool_pool"
    },
    %{
      name: "driving",
      desc: "driving_driving"
    },
    %{
      name: "horse_riding",
      desc: "horse_riding_horse_riding"
    },
    %{
      name: "cars",
      desc: "cars_cars"
    },
    %{
      name: "music",
      desc: "music_music"
    },
    %{
      name: "writing",
      desc: "writing_writing"
    },
    %{
      name: "acting",
      desc: "acting_acting"
    },
    %{
      name: "scuba_diving",
      desc: "scuba_diving_scuba_diving"
    },
    %{
      name: "parachuting",
      desc: "parachuting_parachuting"
    },
    %{
      name: "hunting",
      desc: "hunting_hunting"
    },
    %{
      name: "gaming",
      desc: "gaming_gaming"
    },
    %{
      name: "cooking",
      desc: "cooking_cooking"
    },
    %{
      name: "jogging",
      desc: "jogging_jogging"
    },
    %{
      name: "cycling",
      desc: "cycling_cycling"
    },
    %{
      name: "netflix",
      desc: "netflix_netflix"
    },
    %{
      name: "prime",
      desc: "prime_prime"
    },
    %{
      name: "soccer",
      desc: "soccer_soccer"
    },
    %{
      name: "fishing",
      desc: "fishing_fishing"
    }
  ]

  def seed do
    Enum.map(@interest, &upsert_type/1)
  end

  def upsert_type(params) do
    %Interest{}
    |> Interest.changeset(params)
    |> Repo.insert(on_conflict: :replace_all_except_primary_key, conflict_target: :id)
  end
end


