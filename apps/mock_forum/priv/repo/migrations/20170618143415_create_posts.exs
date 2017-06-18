defmodule MockForum.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :thread_id, references(:threads)
      add :message, :string

      timestamps()
    end
  end
end
