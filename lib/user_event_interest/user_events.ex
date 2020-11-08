defmodule UserEventInterest.UserEvents do

  import Ecto.Query, warn: false
  alias UserEventInterest.Repo
  alias UserEventInterest.Users.UserEvent

  
  def delete_user_event_data(event_id) do
    UserEvent
    |> where([ue], ue.event_id == ^event_id)
    |> Repo.delete_all
  end
  
  def attend_count() do
    UserEvent
    |> where([ue], ue.is_attending == true)
    |> group_by([ue], ue.event_id)
    |> select([ue], %{event_id: ue.event_id, count: count(ue.id)})
    |> Repo.all()
  end

  def cancel_count() do
    UserEvent
    |> where([ue], ue.is_cancelling == true)
    |> group_by([ue], ue.event_id)
    |> select([ue], %{event_id: ue.event_id, count: count(ue.id)})
    |> Repo.all()
  end

  def people_list(event_id) do
    UserEvent
    |> where([i], i.event_id == ^event_id)
    |> select([i], %{user_id: i.user_id, is_attending: i.is_attending})
    |> Repo.all()
  end

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
