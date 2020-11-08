defmodule Intermoto.Contexts.Room.Room do
  use Ecto.Schema
  import Ecto.Changeset

  alias Intermoto.Contexts.People.People
  alias Intermoto.Contexts.Room.Room

  @required [:access_code, :name, :room_code]

  schema "room" do
    field :room_code, :integer, null: false
    field :name, :string, null: false
    field :access_code, :integer, null: false
    field :open, :boolean, null: false, default: true

    has_many :people, People
  end

  def changeset(%Room{} = room, params \\ %{}) do
    room
    |> cast(params, @required)
    |> validate_required(@required)
    |> unique_constraint(:code, name: :unique_room_code)
  end
end
