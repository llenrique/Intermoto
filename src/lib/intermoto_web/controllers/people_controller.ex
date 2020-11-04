defmodule IntermotoWeb.PeopleController do
  use IntermotoWeb, :controller

  alias Intermoto.Contexts.People.PeopleManager
  alias Intermoto.Helpers.People.PeopleHelper

  def index(conn, _params) do
    all = PeopleManager.list()
    all = Enum.map(all, &{"#{&1.name}", &1.id})
    conn
    |> assign(:people, all)
    |> render("index.html")
  end

  def select(conn, %{"people_id" => people_id}) do
    with {:ok, taken_people} <- PeopleHelper.select_people_to_give_gift_for(people_id) do
      conn
      |> assign(:taken_people, taken_people)
      |> render("show.html")
    else
      {:error, message} ->
        IO.inspect("Error al seleccionar persona para dar regalo")

        conn
        |> assign(:error_message, message)
        |> render("error.html")
    end
  end

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"people" => people}) do
    with :ok <- PeopleHelper.create(people) do
      redirect(conn, to: Routes.people_path(conn, :index))
    else
      {:error, message} ->
        conn
        |> assign(:error_message, message)
        |> render("error.html")
    end
  end

  def delete(conn, _params) do
    PeopleManager.delete()

    redirect(conn, to: Routes.people_path(conn, :index))
  end
end
