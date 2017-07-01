defmodule MockForum.Thread do
    @moduledoc false

    use MockForum, :model
    use MockForum.Commands.CrudCommands, 
        record_type:  Thread,
        associations: [posts: :user]

    schema "threads" do
        belongs_to :subject, MockForum.Subject
        has_many :posts, MockForum.Post, on_delete: :delete_all 

        field :title, :string
        timestamps()
    end

    def changeset(struct \\ %Thread{}, params \\ %{}) do
        struct
        |> cast(params, [:title, :subject_id])
        |> cast_assoc(:subject)
        |> cast_assoc(:posts)
        |> validate_required([:title])
    end

    def new_thread(record_params \\ %{}) do
        changeset(%Thread{posts: [Post.changeset]}, record_params)
    end

    def create(subject, user, thread_params) do
        thread_params = assign_user(thread_params, user)

        subject
        |> build_assoc(:threads)
        |> changeset(thread_params)
        |> Repo.insert
    end

    # Ensure that we can assign a user to the given post.

    defp assign_user(params, %{id: id}) do
        assign_nested_struct(params, "posts", "user_id", id, Map.keys(params["posts"]))
    end
end
