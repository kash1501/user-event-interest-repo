defmodule UserEventInterestWeb.SessionController do
  use UserEventInterestWeb, :controller
  alias UserEventInterest.Users

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, params) do
    %{"user" => %{"email" => email, "password" => password}} = params

    case Regex.match?(~r/^[A-Za-z0-9._%+-+']+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/, email) do
      false ->
        conn
        |> put_flash(:error, "E-Mail Format Incorrect")
        |> redirect(to: "/login")

      true ->
        case Users.authenticate_user(email, password) do
          {:ok, db_user} ->
            conn
            |> put_flash(:info, "Welcome Back!")
            |> put_session(:user_id, db_user.id)
            |> configure_session(renew: true)
            |> redirect(to: "/users")

          {:error, :unauthorized} ->
            conn
            |> put_flash(:error, "E-Mail/Password not correct")
            |> redirect(to: "/login")

          {:error, :not_found} ->
            conn
            |> put_flash(:error, "Account not found")
            |> redirect(to: "/login")
        end
    end
  end

  def delete(conn, _) do
    conn
    |> configure_session(drop: true)
    |> put_flash(:success, "Successfully Logged Out")
    |> redirect(to: "/")
  end
end
