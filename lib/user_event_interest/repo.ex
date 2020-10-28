defmodule UserEventInterest.Repo do
  use Ecto.Repo,
    otp_app: :user_event_interest,
    adapter: Ecto.Adapters.Postgres
end
