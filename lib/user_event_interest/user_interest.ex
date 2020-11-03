defmodule UserEventInterest.UserInterests do

  import Ecto.Query, warn: false
  alias UserEventInterest.Repo
  alias UserEventInterest.Users.UserInterest



  # def people_list(event_id) do
  #   UserEvent
  #   |> where([i], i.event_id == ^event_id)
  #   |> select([i], %{user_id: i.user_id, is_attending: i.is_attending})
  #   |> Repo.all()
  # end

  def get_login_user_interests(user_id) do
    UserInterest
    |> where([i], i.user_id == ^user_id)
    |> select([i], %{interest_id: i.interest_id, is_adding: i.is_adding})
    |> Repo.all()
  end

  def get_user_interest(user_id, interest_id) do
    UserInterest
    |> where([i], i.user_id == ^user_id)
    |> where([i], i.interest_id == ^interest_id)
    |> Repo.one()
  end

  # def get_login_user_interests(user_id) do
  #   UserInterest
  #   |> where([i], i.user_id == ^user_id)
  #   |> Repo.all()
  # end

  def yes_no_user_interest(params) do
    user_id = Map.get(params, :user_id)
    interest_id = Map.get(params, :interest_id)
    case get_user_interest(user_id, interest_id) do
      nil ->
        %UserInterest{}
        |> UserInterest.changeset(params)
        |> Repo.insert()

      user_event ->
        user_event
        |> UserInterest.changeset(params)
        |> Repo.update()
    end
  end
end
