defmodule MockForum.Mailbox.Recipient do
    @moduledoc false

    use MockForum, :model
    use MockForum.Commands.CrudCommands,
        record_type:  Recipient,
        associations: []

    schema "mailbox_recipients" do
        belongs_to :message, MockForum.Mailbox.Message
        belongs_to :recipient, MockForum.User

        field :is_read, :boolean
        timestamps()
    end

    def changeset(struct \\ %Recipient{}, params \\ %{}) do
        struct
        |> cast(params, [:is_read, :recipient_id, :message_id])
        |> cast_assoc(:recipient)
        |> cast_assoc(:message)
    end
end
