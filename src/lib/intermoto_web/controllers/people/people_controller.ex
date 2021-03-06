defmodule IntermotoWeb.People.PeopleController do
  use IntermotoWeb, :controller


  alias Intermoto.Contexts.People.People
  alias Intermoto.Contexts.People.PeopleManager
  alias Intermoto.Contexts.Room.RoomManager
  alias Intermoto.Helpers.People.PeopleHelper

  plug(IntermotoWeb.Plugs.CurrentRoomPlug)


  def index(conn, %{"room_id" => room_code}) do
    room = RoomManager.get(room_code)

    room_people = PeopleManager.list(room.id)

    room_people = Enum.map(room_people, &{"#{&1.name}", &1.id})

    conn
    |> assign(:room, room)
    |> assign(:people, room_people)
    |> render("index.html")
  end

  def select(conn, %{"room_id" => room_code, "people_id" => people_id}) do
    room = RoomManager.get(room_code)

    with {:ok, taken_people} <- PeopleHelper.select_people_to_give_gift_for(room.id, people_id) |> IO.inspect() do
      conn
      |> assign(:people, [])
      |> assign(:room_code, room.room_code)
      |> assign(:taken_people, taken_people)
      |> render("show.html")
    else
      {:error, message} ->
        IO.inspect("Error al seleccionar persona para dar regalo")

        conn
        |> assign(:people, [])
        |> assign(:error_message, message)
        |> assign(:room_code, room.room_code)
        |> render("error.html")
    end
  end

  def quick_list(conn, %{"room_id" => room_code}) do
    conn
    |> assign(:people, [])
    |> assign(:room_code, room_code)
    |> render("quick_list.html")
  end

  def list_people(conn, %{"room_id"=> room_code}) do
    room = RoomManager.get(room_code)

    room_people = PeopleManager.list(room.id)

    conn
    |> assign(:room, room)
    |> assign(:people, room_people)
    |> render("list_people.html")
  end

  def new(conn, %{"room_id" => room_code}) do
    conn
    |> assign(:people, [])
    |> assign(:room_code, room_code)
    |> render("new.html")
  end

  def create(conn, %{"room_id" => room_code, "people" => people}) do
    room = RoomManager.get(room_code)

    with :ok <- PeopleHelper.create(room.id, people) do
      redirect(conn, to: Routes.room_people_path(conn, :index, room_code))
    else
      {:error, message} ->
        conn
        |> assign(:error_message, message)
        |> render("error.html")
    end
  end

  def create(conn, %{"room_id" => room_code} = params) do
    room = RoomManager.get(room_code)

    params = Map.put(params, "room_id", room.id) |> IO.inspect

    with {:ok, %People{}} <- PeopleManager.create(params) do
      redirect(conn, to: Routes.room_people_path(conn, :index, room_code))
    else
      {:error, message} ->
        conn
        |> assign(:error_message, message)
        |> render("error.html")
    end
  end

  def delete(conn, _params) do
    PeopleManager.delete()

    redirect(conn, to: Routes.room_people_path(conn, :index))
  end
end
