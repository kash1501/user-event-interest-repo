defmodule UserEventInterestWeb.PageController do
  use UserEventInterestWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
