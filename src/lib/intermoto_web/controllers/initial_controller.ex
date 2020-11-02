defmodule IntermotoWeb.InitialController do
  use IntermotoWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
