defmodule Intermoto.Helpers.People.PeopleHelper do

  alias Intermoto.Contexts.People.PeopleManager
  alias Intermoto.Contexts.People.People

  def select_people_to_give_gift_for(people_id) do
    case PeopleManager.get(people_id) do
      %People{select_status: true} ->
        {:error, "Tu ya tienes a quien dar regalo, no seas tramposo"}

      selector ->
        PeopleManager.update(selector, %{select_status: true})

        people_id
        |> PeopleManager.get_not_taken()
        |> _select_random()
    end
  end

  defp _select_random(people_list) do
    with [taken_person] <- Enum.take_random(people_list, 1) do
      PeopleManager.update(taken_person, %{taken_status: true})
    else
      [] ->
        {:error, "Ha ocurrido un error"}
    end
  end

  def create(people) do
    people
    |> String.split(",")
    |> Enum.map(fn p ->
      PeopleManager.create(%{name: p})
    end)
  end
end
