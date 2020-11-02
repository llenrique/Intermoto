defmodule Intermoto.Repo.Migrations.CreatePeopleTable do
  use Ecto.Migration

  def up do
    create table(:people) do
      add :name, :string, [null: false]
      add :taken_status, :boolean, default: false
      add :select_status, :boolean, default: false
      timestamps()
    end
  end

  def down do
    alter table(:people) do
      remove :name
      remove :taken_status
      remove :select_status
    end
  end
end
