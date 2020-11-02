defmodule Intermoto.Contexts.People.PeopleManagerTest do
  use Intermoto.DataCase

  import Intermoto.Factory

  alias Intermoto.Contexts.People.PeopleManager

  test "list/0 all the people in database" do
    people = insert_list(5, :people)

    taken_from_database = PeopleManager.list()

    assert length(taken_from_database) == 5
    assert length(people) == 5
  end


  test "list/1 Get all people with selected_status as true" do
    insert(:people, select_status: true, name: "Alis")
    insert(:people, select_status: true, name: "Bety")
    insert(:people, select_status: true, name: "Agustin")
    insert(:people, select_status: true, name: "Beto")
    insert(:people, select_status: false, name: "Concha")
    insert(:people, select_status: false, name: "Fer")
    insert(:people, select_status: false, name: "Rolando")
    insert(:people, select_status: false)

    selected_people = PeopleManager.list()

    Enum.take_random(selected_people, 1)

    assert length(selected_people) == 8
  end

  test "update/2 Updates select_status from people to true" do
    people = insert(:people)

    {:ok, update_people} = PeopleManager.update(people, %{select_status: true})

    assert people.name == update_people.name
    assert people.select_status != update_people.select_status
  end
end
