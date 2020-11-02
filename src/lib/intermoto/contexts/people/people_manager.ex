defmodule Intermoto.Contexts.People.PeopleManager do

  import Ecto.Query, warn: false

  alias Intermoto.Repo
  alias Intermoto.Contexts.People.People

  def list() do
    People
    |> where([p], p.select_status == false)
    |> select([p], %{
      name: p.name,
      id: p.id
    })
    |> order_by([p], p.name)
    |> Repo.all()
  end

  def get_not_taken(id) do
    People
    |> where([p], p.id != ^id and p.taken_status == false)
    |> Repo.all
  end

  def update(%People{} = people, attrs) do
    people
    |> People.update_changeset(attrs)
    |> Repo.update
  end

  def get(id), do: Repo.get(People, id)

  def get_all(), do: Repo.all(People)
end
