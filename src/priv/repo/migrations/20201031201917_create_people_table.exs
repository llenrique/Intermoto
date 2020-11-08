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
    drop table(:people)
  end
end
