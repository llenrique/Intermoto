defmodule Intermoto.Contexts.Room.RoomManager do

  import Ecto.Query, warn: false

  alias Intermoto.Repo
  alias Intermoto.Contexts.Room.Room

  def create(attrs) do
    %Room{}
    |> Room.changeset(attrs)
    |> Repo.insert()
    |> IO.inspect
  end

  def get_code(room_code) do
    Room
    |> where([room], room.room_code == ^room_code)
    |> select([room], %{
      room_code: room.room_code
    })
    |> Repo.one()
    |> IO.inspect
  end

  def get(room_code) do
    Room
    |> where([room], room.room_code == ^room_code)
    |> Repo.one()
  end
end
