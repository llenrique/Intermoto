defmodule Intermoto.Contexts.Room.Room do
  use Ecto.Schema
  import Ecto.Changeset

  alias Intermoto.Contexts.People.People
  alias Intermoto.Contexts.Room.Room

  @required [:access_code, :name, :room_code]

  schema "room" do
    field :room_code, :integer, null: false
    field :name, :string, null: false
    field :access_code, :string, null: false
    field :open, :boolean, null: false, default: true

    has_many :people, People
  end

  def changeset(%Room{} = room, params \\ %{}) do
    room
    |> cast(params, @required)
    |> unique_constraint(:code, name: :unique_room_code)
    |> encrypt_access_code()
    |> validate_required(@required)
  end

  def encrypt_access_code(changeset) do
    with access_code when not is_nil(access_code) <- get_change(changeset, :access_code) do
      put_change(changeset, :access_code, Bcrypt.hash_pwd_salt(access_code))
    else
      _ -> changeset
    end
  end
end
