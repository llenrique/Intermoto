defmodule Intermoto.Contexts.People.People do

  use Ecto.Schema
  import Ecto.Changeset

  alias Intermoto.Contexts.People.People

  schema "people" do
    field :name, :string, null: false
    field :taken_status, :boolean, default: false
    field :select_status, :boolean, default: false
    timestamps()
  end

  def changeset(%People{} = people, params) do
    people
    |> cast(params, [:name])
  end

  def update_changeset(%People{} = people, params) do
    people
    |> cast(params, [:select_status, :taken_status])
  end
end
