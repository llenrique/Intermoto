defmodule IntermotoWeb.InitialController do
  use IntermotoWeb, :controller

  plug :put_layout, "initial.html"

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
