defmodule StipeWeb.Router do
  use StipeWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_flash
    plug Phoenix.LiveView.Flash
  end

  pipeline :auth do
    plug StipeWeb.Auth
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", StipeWeb do
    pipe_through :browser

    get "/", HomeController, :index
    post "/verify_email", HomeController, :verify_email, as: :verify_email
    resources "/daily_updates", DailyUpdateController
    resources "/sessions", SessionController, only: [:new, :create, :delete]
  end

  scope "/admin", StipeWeb.Admin do
    pipe_through [:browser, :auth]

    resources "/users", UserController do
      resources "/daily_updates", DailyUpdateController
    end

    resources "/organizations", OrganizationController
  end

  # Other scopes may use custom stacks.
  # scope "/api", StipeWeb do
  #   pipe_through :api
  # end
end
