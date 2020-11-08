defmodule IntermotoWeb.Room.RoomController do
  use IntermotoWeb, :controller

  alias Intermoto.Helpers.Room.RoomHelper
  alias Intermoto.Contexts.Room.RoomManager

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def create(conn, %{"name" => name} = params) do
    with {:ok, room} <- RoomHelper.create(params) do
      redirect(conn, to: Routes.room_path(conn, :show, room.room_code))
    end
  end

  def show(conn, %{"id" => room_code}) do
    case RoomManager.get(room_code) do
      [] ->
        redirect(conn, to: Routes.room_path(conn, :index))
      room ->
        conn
        |> assign(:room, room)
        |> render("show.html")
    end
  end
end
