defmodule UserEventInterest.UserEvents do


  import Ecto.Query, warn: false
  alias UserEventInterest.Repo

  alias UserEventInterest.Users.UserEvent

  def attending_event(user_id) do
    UserEvent
    |> where([i], i.user_id == ^user_id)
    |> select([i], %{event_id: i.event_id, is_attending: i.is_attending})
    |> Repo.all()
  end

  def get_user_event(user_id, event_id) do
    UserEvent
    |> where([i], i.user_id == ^user_id)
    |> where([i], i.event_id == ^event_id)
    |> Repo.one()
  end

  def get_specific_user_events(user_id) do
    UserEvent
    |> where([i], i.user_id == ^user_id)
    |> Repo.all()
  end

  def yes_no_user_event(params) do
    user_id = Map.get(params, :user_id)
    event_id = Map.get(params, :event_id)
    case get_user_event(user_id, event_id) do
      nil ->
        %UserEvent{}
        |> UserEvent.changeset(params)
        |> Repo.insert()

      user_event ->
        user_event
        |> UserEvent.changeset(params)
        |> Repo.update()
    end
  end
end
