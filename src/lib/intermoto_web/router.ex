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

    resources "/room", Room.RoomController, only: [:new, :create, :show, :index] do
      get "/reset", ResetController, :reset
      get "/people/select", People.PeopleController, :select
      get "/people/quick_list", People.PeopleController, :quick_list
      resources "/people", People.PeopleController
    end

    resources "/sessions", SessionController, only: [:create, :delete]
    get "/login-room", SessionController, :new
    get "/logout-room", SessionController, :delete

  end


  # Other scopes may use custom stacks.
  # scope "/api", IntermotoWeb do
  #   pipe_through :api
  # end
end
