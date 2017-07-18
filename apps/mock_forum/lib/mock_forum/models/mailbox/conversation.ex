defmodule MockForum.Mailbox.Conversation do
    @moduledoc false

    use MockForum, :model
    use MockForum.Commands.CrudCommands,
        record_type:  Conversation,
        associations: [messages: [:recipient]]

    schema "mailbox_conversations" do
        has_many :messages, MockForum.Mailbox.Message, on_delete: :delete_all
        timestamps()
    end

    def changeset(struct \\ %Conversation{}, params \\ %{}) do
        struct
    end
end
