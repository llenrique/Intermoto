defmodule IntermotoWeb.Room.RoomController do
  use IntermotoWeb, :controller

  alias Intermoto.Helpers.Room.RoomHelper
  alias Intermoto.Contexts.Room.RoomManager

  plug(IntermotoWeb.Plugs.CurrentRoomPlug)

  def new(conn, _params) do
    conn
    |> assign(:people, [])
    |> render("new.html")
  end

  def create(conn, params) do
    with {:ok, room} <- RoomHelper.create(params) do
      redirect(conn, to: Routes.room_path(conn, :show, room.room_code))
    else
      {:error, _errors} ->
        redirect(conn, to: Routes.room_path(conn, :new))
    end
  end

  def show(conn, %{"id" => room_code}) do
    case RoomManager.get_code(room_code) do
      [] ->
        redirect(conn, to: Routes.room_path(conn, :index))
      room ->
        conn
        |> assign(:people, [])
        |> assign(:room, room)
        |> render("show.html")
    end
  end

  def index(conn, %{"room_code" => room_code}) do
    room = RoomManager.get(room_code)

    conn
    |> assign(:room, room)
    |> render("room.html")
  end
end
