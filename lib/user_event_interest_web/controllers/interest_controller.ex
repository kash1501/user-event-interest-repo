defmodule UserEventInterestWeb.InterestController do
  use UserEventInterestWeb, :controller

  alias UserEventInterest.Interests
  alias UserEventInterest.Interests.Interest

  def index(conn, _params) do
    interests = Interests.list_interests()
    render(conn, "index.html", interests: interests)
  end

  def new(conn, _params) do
    changeset = Interests.change_interest(%Interest{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"interest" => interest_params}) do
    case Interests.create_interest(interest_params) do
      {:ok, interest} ->
        conn
        |> put_flash(:info, "Interest created successfully.")
        |> redirect(to: Routes.interest_path(conn, :show, interest))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    interest = Interests.get_interest!(id)
    render(conn, "show.html", interest: interest)
  end

  def edit(conn, %{"id" => id}) do
    interest = Interests.get_interest!(id)
    changeset = Interests.change_interest(interest)
    render(conn, "edit.html", interest: interest, changeset: changeset)
  end

  def update(conn, %{"id" => id, "interest" => interest_params}) do
    interest = Interests.get_interest!(id)

    case Interests.update_interest(interest, interest_params) do
      {:ok, interest} ->
        conn
        |> put_flash(:info, "Interest updated successfully.")
        |> redirect(to: Routes.interest_path(conn, :show, interest))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", interest: interest, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    interest = Interests.get_interest!(id)
    {:ok, _interest} = Interests.delete_interest(interest)

    conn
    |> put_flash(:info, "Interest deleted successfully.")
    |> redirect(to: Routes.interest_path(conn, :index))
  end
end
