defmodule Intermoto.Contexts.People.People do

  use Ecto.Schema
  import Ecto.Changeset

  alias Intermoto.Contexts.People.People
  alias Intermoto.Contexts.Room.Room

  schema "people" do
    field :name, :string, null: false
    field :taken_status, :boolean, default: false
    field :select_status, :boolean, default: false

    belongs_to :room, Room
    timestamps()
  end

  def changeset(%People{} = people, params) do
    people
    |> cast(params, [:name])
    |> validate_required([:name])
  end

  def update_changeset(%People{} = people, params) do
    people
    |> cast(params, [:select_status, :taken_status])
  end
end
