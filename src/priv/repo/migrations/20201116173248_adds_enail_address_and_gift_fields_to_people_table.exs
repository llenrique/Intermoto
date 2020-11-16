defmodule Intermoto.Repo.Migrations.AddsEnailAddressAndGiftFieldsToPeopleTable do
  use Ecto.Migration

  def up do
    alter table(:people) do
      add :email, :string
      add :address, :string
      add :gift, :string
    end
  end

  def down do
    alter table(:people) do
      remove :email
      remove :address
      remove :gift
    end
  end
end
