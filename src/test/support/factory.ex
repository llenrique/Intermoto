defmodule Intermoto.Factory do
  use ExMachina.Ecto, repo: Intermoto.Repo

  use Intermoto.PeopleFactory
end
