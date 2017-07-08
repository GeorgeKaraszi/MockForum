defmodule MockForum.Repo.Migrations.CreateThreads do
  use Ecto.Migration

  def change do
    create table(:threads) do
      add :subject_id, references(:subjects, on_delete: :delete_all)
      add :title, :string
      timestamps()
    end
  end
end
