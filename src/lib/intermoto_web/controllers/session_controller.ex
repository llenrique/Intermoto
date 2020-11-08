defmodule IntermotoWeb.SessionController do
  use IntermotoWeb, :controller

  alias Intermoto.Contexts.Room.RoomManager

  def new(conn, _params) do
    case get_session(conn, :room) do
      nil ->
        render(conn, "new.html")
      room ->
        redirect(conn, to: Routes.room_people_path(conn, :new))
    end
  end

  def create(conn, %{
    "room_code" => room_code,
    "access_code" => access_code
  }) do
    with room <- RoomManager.get(room_code),
      {:ok, access_room} <- _access_room(room, access_code) do
        conn
        |> put_session(:room, %{
          room_code: room.room_code,
        })
        |> redirect(to: Routes.room_people_path(conn, :index, room_code))
      else
        {:error, _} ->
          conn
          |> redirect(to: Routes.session_path(conn, :new))
    end
  end

  def delete(conn, _params) do
    conn
    |> delete_session(:room)
    |> redirect(to: Routes.session_path(conn, :new))
  end

  defp _access_room(room, access_code) do
    Bcrypt.check_pass(room, access_code, hash_key: :access_code)
  end
end
