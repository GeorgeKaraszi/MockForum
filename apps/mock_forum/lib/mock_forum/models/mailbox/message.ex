defmodule MockForum.Mailbox.Message do
    @moduledoc false

    use MockForum, :model
    use MockForum.Commands.CrudCommands,
        record_type:  Message,
        associations: [:recipients]

    schema "mailbox_messages" do
        belongs_to :conversation, MockForum.Mailbox.Conversation
        belongs_to :sender, MockForum.User

        has_many :recipients, MockForum.Mailbox.Recipient, on_delete: :delete_all

        field :body, :string
        timestamps()
    end

    def changeset(struct \\ %Message{}, params \\ %{}) do
        struct
        |> cast(params, [:body, :sender_id, :conversation_id])
        |> cast_assoc(:conversation)
        |> cast_assoc(:sender)
        |> validate_required([:body])
    end
end
