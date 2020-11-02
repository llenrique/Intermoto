defmodule Intermoto.PeopleFactory do
  alias Intermoto.Contexts.People.People

  defmacro __using__(_opts) do
    quote do
      def people_factory do
        %People{
          name: "Enrique",
          select_status: false
        }
      end
    end
  end
end
