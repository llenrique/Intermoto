defmodule IntermotoWeb.Plugs.CurrentRoomPlug do
  @moduledoc """
  Plug para agregar a los assigns de conn el usuario actual. Se debe usar posterior
  al plug que verifica que haya una sesión
  """

  import Plug.Conn

  def init(default), do: default

  def call(conn, _default) do
    room = get_session(conn, :room)

    assign(conn, :room, room)
  end
end
