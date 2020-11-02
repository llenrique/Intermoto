defmodule IntermotoWeb.ResetController do
  use IntermotoWeb, :controller

  alias Intermoto.Contexts.People.PeopleManager

  def reset(conn, _params) do
    all_people = PeopleManager.get_all()

    Enum.each(all_people, fn people ->
      PeopleManager.update(people, %{select_status: false, taken_status: false})
    end)

    redirect(conn, to: Routes.people_path(conn, :index))
  end
end
