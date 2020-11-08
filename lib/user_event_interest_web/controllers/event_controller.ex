defmodule UserEventInterestWeb.EventController do
  use UserEventInterestWeb, :controller

  alias UserEventInterest.Events
  alias UserEventInterest.Events.Event
  alias UserEventInterest.UserEvents
  alias UserEventInterest.Users.User
  alias UserEventInterest.Users
  alias UserEventInterest.Utility.LoginUser

  def index(conn, _params) do
    event_is = Events.list_events()
    login_user_id = LoginUser.get_login_user_id(conn)
    attend_event = UserEvents.attending_event(login_user_id)
    attendee_count = UserEvents.attend_count()
    cancel_count = UserEvents.cancel_count()
    render(conn, "index.html", event_is: event_is, login_user_id: login_user_id, attend_event: attend_event, attendee_count: attendee_count, cancel_count: cancel_count)
  end

  def new(conn, _params) do
    changeset = Events.change_event(%Event{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"event" => event_params}) do
    login_user_id = LoginUser.get_login_user_id(conn)
    event_param_id = Map.merge(event_params, %{"user_id" => login_user_id})
    case Events.create_event(event_param_id) do
      {:ok, event} ->
        conn
        |> put_flash(:info, "Event created successfully.")
        |> redirect(to: Routes.event_path(conn, :show, event))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    login_user_id = LoginUser.get_login_user_id(conn)
    event = Events.get_event!(id)
    users = Users.list_users()
    user_events = UserEvents.people_list(id)
    login_user = Users.get_user!(login_user_id)
    render(conn, "show.html", event: event, users: users, user_events: user_events, login_user: login_user)
  end

  def edit(conn, %{"id" => id}) do
    event = Events.get_event!(id)
    changeset = Events.change_event(event)
    render(conn, "edit.html", event: event, changeset: changeset)
  end

  def update(conn, %{"id" => id, "event" => event_params}) do
    event = Events.get_event!(id)

    case Events.update_event(event, event_params) do
      {:ok, event} ->
        conn
        |> put_flash(:info, "Event updated successfully.")
        |> redirect(to: Routes.event_path(conn, :show, event))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", event: event, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    event = Events.get_event!(id)
    delete_user_event = UserEvents.delete_user_event_data(id)
    {:ok, _event} = Events.delete_event(event)

    conn
    |> put_flash(:info, "Event deleted successfully.")
    |> redirect(to: Routes.event_path(conn, :index))
  end
end
