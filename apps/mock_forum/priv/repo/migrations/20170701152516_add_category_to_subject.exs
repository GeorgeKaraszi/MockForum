defmodule MockForum.Repo.Migrations.AddCategoryToSubject do
  use Ecto.Migration

  def change do
    alter table(:subjects) do
      add :category_id, references(:categories)
    end
  end
end
