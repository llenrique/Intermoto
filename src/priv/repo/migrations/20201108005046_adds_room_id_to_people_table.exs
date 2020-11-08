defmodule Intermoto.Repo.Migrations.AddsRoomIdToPeopleTable do
  use Ecto.Migration

  def up do
    alter table(:people) do
      add :room_id, references(:room)
    end
  end

  def down do
    alter table(:people) do
      remove :room_id
    end
  end
end
