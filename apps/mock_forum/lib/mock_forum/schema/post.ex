defmodule MockForum.Post do
    @moduledoc false

    use MockForum, :model

    schema "posts" do
        belongs_to :thread, MockForum.Thread
        belongs_to :user, MockForum.User
        field :message, :string

        timestamps()
    end

    def changeset(struct, params \\ %{}) do
        struct
        |> cast(params, [:message, :user_id, :thread_id])
        |> cast_assoc(:thread)
        |> cast_assoc(:user)
        |> validate_required([:message])
    end
end