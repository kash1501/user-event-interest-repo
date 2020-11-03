defmodule UserEventInterestWeb.Router do
  use UserEventInterestWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", UserEventInterestWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/login", SessionController, :new
    get "/signup", UserController, :new
    get "/accept_invitation_for_event/:id/:user_id", UserController, :accept_invitation_for_event
    get "/cancel_invitation_for_event/:id/:user_id", UserController, :cancel_invitation_for_event
    get "/accept_invitation/:id", UserController, :accept_invitation
    get "/cancel_invitation/:id", UserController, :cancel_invitation
    get "/add_interest/:id", UserController, :add_interest
    resources "/users", UserController
    resources "/interests", InterestController
    resources "/events", EventController
    resources "/sessions", SessionController, only: [:new, :create], singleton: true

  end

  # Other scopes may use custom stacks.
  # scope "/api", UserEventInterestWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: UserEventInterestWeb.Telemetry
    end
  end
end
