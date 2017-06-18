defmodule MockForum.Post do
    @moduledoc false

    use MockForum, :model

    schema "posts" do
        belongs_to :thread, MockForum.Thread
        field :message, :string

        timestamps()
    end

    def changeset(struct, params \\ %{}) do
        struct
        |> cast(params, [:message, :thread_id])
        |> cast_assoc(:thread)
        |> validate_required([:message])
    end
end