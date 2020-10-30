defmodule UserEventInterestWeb.SessionController do
  use UserEventInterestWeb, :controller
  alias UserEventInterest.Users

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, params) do
    %{"user" => %{"email" => email, "password" => password}} = params
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
