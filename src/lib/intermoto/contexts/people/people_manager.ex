defmodule Intermoto.Contexts.People.PeopleManager do

  import Ecto.Query, warn: false

  alias Intermoto.Repo
  alias Intermoto.Contexts.People.People

  def list(room_id) do
    People
    |> where([p], p.select_status == false)
    |> where([p], p.room_id == ^room_id)
    |> select([p], %{
      name: p.name,
      id: p.id,
      email: p.email,
      address: p.address,
      gift: p.gift,
      taken_status: p.taken_status,
      select_status: p.select_status
    })
    |> order_by([p], p.name)
    |> Repo.all()
  end

  def get_not_taken(id, room_id) do
    People
    |> where([p], p.id != ^id)
    |> where([p], p.taken_status == false)
    |> where([p], p.room_id == ^room_id)
    |> Repo.all
  end

  def update(%People{} = people, attrs) do
    people
    |> People.update_changeset(attrs)
    |> Repo.update
  end

  def create(attrs) do
    %People{}
    |> People.changeset(attrs)
    |> Repo.insert
  end

  def delete() do
    People
    |> Repo.delete_all()
  end

  def get(id), do: Repo.get(People, id)

  def get_all(), do: Repo.all(People)

  def get_all_by_room(room_id) do
    People
    |> where([p], p.room_id == ^room_id)
    |> Repo.all()
  end
end
