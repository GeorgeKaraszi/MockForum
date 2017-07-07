defmodule MockForum.Post do
    @moduledoc false

    use MockForum, :model
    use MockForum.Commands.CrudCommands,
        record_type:  Post,
        associations: []

    schema "posts" do
        belongs_to :thread, MockForum.Thread
        belongs_to :user, MockForum.User
        field :message, :string

        timestamps()
    end

    def changeset(struct \\ %Post{}, params \\ %{}) do
        struct
        |> cast(params, [:message, :user_id, :thread_id])
        |> cast_assoc(:thread)
        |> cast_assoc(:user)
        |> validate_required([:message])
    end

    def create(thread, user, post_params) do
     %Post{}
        |> changeset(post_params)
        |> change
        |> put_assoc(:user, user, required: true)
        |> put_assoc(:thread, thread, required: true)
        |> Repo.insert
    end

    def latest_posts do
        from p in Post,
        order_by: [desc: p.inserted_at],
        distinct: p.thread_id,
        preload: [:user]
    end
end
