defmodule IntermotoWeb.VerifyRoomSession do

  import Plug.Conn, only: [get_session: 2, halt: 1]
  alias IntermotoWeb.Router.Helpers, as: Routes
  import Phoenix.Controller, only: [put_flash: 3, redirect: 2]

  def init(opts), do: opts

  def call(conn, _opts) do
    case get_session(conn, :room) do
      nil ->
        conn
        |> put_flash(:error, "You must be logged in to do this")
        |> redirect(to: Routes.session_path(conn, :new))
        |> halt()
      _session ->
        conn
    end
  end
end
