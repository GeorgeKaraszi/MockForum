defmodule MockForum.Repo.Migrations.AddAvatarToUser do
  @moduledoc false

  use Ecto.Migration

  def change do
    alter table(:users) do
      add :avatar, :string
    end
  end
end
