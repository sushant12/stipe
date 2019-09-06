defmodule StipeWeb.Router do
  use StipeWeb, :router

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

  scope "/", StipeWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/admin", StipeWeb.Admin do
    pipe_through :browser

    resources "/users", UserController
    resources "/organizations", OrganizationController
  end

  # Other scopes may use custom stacks.
  # scope "/api", StipeWeb do
  #   pipe_through :api
  # end
end
