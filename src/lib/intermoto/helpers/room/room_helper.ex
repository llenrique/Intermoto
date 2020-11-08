defmodule Intermoto.Helpers.Room.RoomHelper do

  alias Intermoto.Contexts.Room.RoomManager

  def create(params) do
    params = Map.put(params, "room_code", :rand.uniform(99999))
    case RoomManager.create(params) do
      {:ok, room} -> {:ok, room}
      {:error,  %Ecto.Changeset{
        errors: errors
      }} -> {:error, errors}
    end
  end
end
