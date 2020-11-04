defmodule IntermotoWeb.Router do
  use IntermotoWeb, :router

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

  scope "/", IntermotoWeb do
    pipe_through :browser

    get "/", InitialController, :index
    get "/reset", ResetController, :reset
    get "/list", PeopleController, :index
    put "/delete", PeopleController, :delete
    get "/select", PeopleController, :select
    get "new", PeopleController, :new
    get "/delete", PeopleController, :delete
    post "/", PeopleController, :create
  end

  # Other scopes may use custom stacks.
  # scope "/api", IntermotoWeb do
  #   pipe_through :api
  # end
end
