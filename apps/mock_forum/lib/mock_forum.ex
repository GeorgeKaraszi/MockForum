defmodule MockForum do
  @moduledoc false

  def model do
    quote do
      use Ecto.Schema
      import Ecto
      import Ecto.Changeset
      import Ecto.Query
      import MockForum.Commands.StructCommands
      alias MockForum.{Repo, User, Thread, Post, Category, Avatar}
    end
  end

    def commands do
    quote do
      use Ecto.Schema
      import Ecto
      import Ecto.Changeset
      import Ecto.Query
      alias MockForum.{Repo, User, Category, Thread, Post}
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
