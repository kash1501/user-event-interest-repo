defmodule UserEventInterestWeb.UserController do
  use UserEventInterestWeb, :controller

  alias UserEventInterest.Users
  alias UserEventInterest.Users.User
  alias UserEventInterest.UserEvents
  alias UserEventInterest.Events

  def index(conn, _params) do
    users = Users.list_users()
    render(conn, "index.html", users: users)
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
      {:ok, user_event} ->
        conn
        |> put_flash(:info, "Invite Accepted Successfully")
        |> redirect(to: Routes.event_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
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
      {:ok, user_event} ->
        conn
        |> put_flash(:info, "Invite Accepted Successfully")
        |> redirect(to: Routes.event_path(conn, :show, event_struct))

      {:error, %Ecto.Changeset{} = changeset} ->
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
      {:ok, user_event} ->
        conn
        |> put_flash(:info, "Invite Cancelled Successfully")
        |> redirect(to: Routes.event_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
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
      {:ok, user_event} ->
        conn
        |> put_flash(:info, "Invite Cancelled Successfully")
        |> redirect(to: Routes.event_path(conn, :show, event_struct))

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:error, "Unable to Cancel the invite")
        |> redirect(to: Routes.event_path(conn, :index))
    end
  end
end
