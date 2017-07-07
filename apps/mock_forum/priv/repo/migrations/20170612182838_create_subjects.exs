defmodule MockForum.Repo.Migrations.CreateSubjects do
  @moduledoc false

  use Ecto.Migration

  def change do
    create table(:subjects) do
      add :title, :string
      add :description, :string

      timestamps()
    end
  end
end
