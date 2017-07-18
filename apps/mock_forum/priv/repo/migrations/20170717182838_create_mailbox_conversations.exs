defmodule MockForum.Repo.Migrations.CreateMailboxConversations do
  use Ecto.Migration

  def change do
    create table(:mailbox_conversations) do
      timestamps()
    end

    create table(:mailbox_messages) do
      add :conversation_id, references(:mailbox_conversations, on_delete: :delete_all)
      add :sender_id, references(:users)
      add :body, :string

      timestamps()
    end

    create table(:mailbox_recipients) do
      add :message_id, references(:mailbox_messages, on_delete: :delete_all)
      add :recipient_id, references(:users)
      add :is_read, :boolean, default: false

      timestamps()
    end
  end
end
