defmodule IntermotoWeb.ResetController do
  use IntermotoWeb, :controller

  alias Intermoto.Contexts.People.PeopleManager
  alias Intermoto.Contexts.Room.RoomManager

  def reset(conn, %{"room_id" => room_code}) do
    room = RoomManager.get(room_code)

    all_people = PeopleManager.get_all_by_room(room.id)

    Enum.each(all_people, fn people ->
      PeopleManager.update(people, %{select_status: false, taken_status: false})
    end)

    redirect(conn, to: Routes.room_people_path(conn, :index, room_code))
  end
end
