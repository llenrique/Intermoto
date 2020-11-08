defmodule Intermoto.Repo.Migrations.CreatesRoomTable do
  use Ecto.Migration

  def up do
    create table(:room) do
      add :room_code, :integer, null: false
      add :name, :string, null: false
      add :access_code, :string, null: false
      add :open, :boolean, null: false, default: true
    end
    create  index(:room, [:id])

    create unique_index(:room, [:room_code], name: :unique_room_code)
  end

  def down do
    drop table(:room)
    drop index(:room, :unique_room_code)
  end
end
