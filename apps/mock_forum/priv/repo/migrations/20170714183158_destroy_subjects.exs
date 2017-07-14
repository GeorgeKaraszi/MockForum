defmodule MockForum.Repo.Migrations.MigrateSubjectToCategory do
  use Ecto.Migration

  def change do
    # alter table(:threads) do
    #   add :user_id, references(:users)
    # end
    alter table(:subjects) do
      remove :category_id
    end
    drop table(:categories)
    rename table(:subjects), to: table(:categories)
    rename table(:threads), :subject_id, to: :category_id
  end

end
