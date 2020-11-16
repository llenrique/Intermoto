defmodule Intermoto.Contexts.People.People do

  use Ecto.Schema
  import Ecto.Changeset

  alias Intermoto.Contexts.People.People
  alias Intermoto.Contexts.Room.Room

  @required [:name, :room_id]
  @optional [:email, :address, :gift]

  schema "people" do
    field :name, :string, null: false
    field :taken_status, :boolean, default: false
    field :select_status, :boolean, default: false
    field :email, :string
    field :address, :string
    field :gift, :string

    belongs_to :room, Room
    timestamps()
  end

  def changeset(%People{} = people, params) do
    people
    |> cast(params, @required ++ @optional)
    |> validate_required(@required)
  end

  def update_changeset(%People{} = people, params) do
    people
    |> cast(params, @optional ++ [:select_status, :taken_status])
  end
end
