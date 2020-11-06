defmodule UserEventInterestWeb.UserController do
  use UserEventInterestWeb, :controller

  alias UserEventInterest.Users
  alias UserEventInterest.Users.User
  alias UserEventInterest.UserEvents
  alias UserEventInterest.Events
  alias UserEventInterest.UserInterests

  def index(conn, _) do
    %{private: %{:plug_session => %{"user_id" => login_user_id}}} = conn
    users = Users.list_users()
    login_user = Users.get_user!(login_user_id)
    render(conn, "index.html", users: users, login_user_id: login_user_id, login_user: login_user)
  end

  def new(conn, _params) do
    changeset = Users.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Users.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: Routes.user_path(conn, :show, user))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    render(conn, "show.html", user: user)
  end

  def edit(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    changeset = Users.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Users.get_user!(id)

    case Users.update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: Routes.user_path(conn, :show, user))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    {:ok, _user} = Users.delete_user(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: Routes.user_path(conn, :index))
  end

  def accept_invitation(conn, event) do
    %{private: %{:plug_session => %{"user_id" => user_id}}} = conn
    %{"id" => event_id} = event
    user_event_map = %{user_id: user_id, event_id: event_id, is_attending: true, is_cancelling: false}
    case UserEvents.yes_no_user_event(user_event_map) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Invite Accepted Successfully")
        |> redirect(to: Routes.event_path(conn, :index))

      {:error, _} ->
        conn
        |> put_flash(:error, "Unable to Accept the invite")
        |> redirect(to: Routes.event_path(conn, :index))
    end
  end

  def accept_invitation_for_event(conn, event) do
    %{"id" => event_id, "user_id" => user_id} = event
    user_event_map = %{user_id: user_id, event_id: event_id, is_attending: true, is_cancelling: false}
    event_struct = Events.get_event!(event_id)
    case UserEvents.yes_no_user_event(user_event_map) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Invite Accepted Successfully")
        |> redirect(to: Routes.event_path(conn, :show, event_struct))

      {:error, _} ->
        conn
        |> put_flash(:error, "Unable to Accept the invite")
        |> redirect(to: Routes.event_path(conn, :index))
    end
  end

  def cancel_invitation(conn, event) do
    %{private: %{:plug_session => %{"user_id" => user_id}}} = conn
    %{"id" => event_id} = event
    user_event_map = %{user_id: user_id, event_id: event_id, is_attending: false, is_cancelling: true}
    case UserEvents.yes_no_user_event(user_event_map) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Invite Cancelled Successfully")
        |> redirect(to: Routes.event_path(conn, :index))

      {:error, _} ->
        conn
        |> put_flash(:error, "Unable to Cancel the invite")
        |> redirect(to: Routes.event_path(conn, :index))
    end
  end

  def cancel_invitation_for_event(conn, event) do
    %{"id" => event_id, "user_id" => user_id} = event
    user_event_map = %{user_id: user_id, event_id: event_id, is_attending: false, is_cancelling: true}
    event_struct = Events.get_event!(event_id)
    case UserEvents.yes_no_user_event(user_event_map) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Invite Cancelled Successfully")
        |> redirect(to: Routes.event_path(conn, :show, event_struct))

      {:error, _} ->
        conn
        |> put_flash(:error, "Unable to Cancel the invite")
        |> redirect(to: Routes.event_path(conn, :index))
    end
  end

  def add_interest(conn, interest) do
    %{private: %{:plug_session => %{"user_id" => login_user_id}}} = conn
    %{"id" => interest_id} = interest
    user_interest_map = %{user_id: login_user_id, interest_id: interest_id, is_adding: true}
    case UserInterests.yes_no_user_interest(user_interest_map) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "Interest Added Successfully")
        |> redirect(to: Routes.interest_path(conn, :index))

      {:error, _} ->
        conn
        |> put_flash(:error, "Unable to Add the interest")
        |> redirect(to: Routes.interest_path(conn, :index))
    end
  end
end
