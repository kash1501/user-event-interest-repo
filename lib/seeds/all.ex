defmodule Seeds.All do
  alias Seeds.Interest

  def seed do
    do_seed()
  end

  defp do_seed() do
    Interest.seed()
  end
end
