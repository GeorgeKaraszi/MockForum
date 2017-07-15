defmodule MockForum.Thread do
    @moduledoc false

    use MockForum, :model
    use MockForum.Commands.CrudCommands,
        record_type:  Thread,
        associations: [posts: :user]

    schema "threads" do
        belongs_to :category, MockForum.Category
        has_many :posts, MockForum.Post, on_delete: :delete_all
        field :title, :string

        # Virtual / Decorator fields
        field :latest_post, :string, virtual: true

        timestamps()
    end

    def changeset(struct \\ %Thread{}, params \\ %{}) do
        struct
        |> cast(params, [:title, :category_id])
        |> cast_assoc(:category)
        |> cast_assoc(:posts)
        |> validate_required([:title])
    end

    def new_thread(record_params \\ %{}) do
        changeset(%Thread{posts: [Post.changeset]}, record_params)
    end

    def create(category, user, thread_params) do
        thread_params = assign_user(thread_params, user)

        category
        |> build_assoc(:threads)
        |> changeset(thread_params)
        |> Repo.insert
    end

    def latest_threads do
        from t in Thread,
        join: p in assoc(t, :posts),
        preload: [posts: ^Post.latest_posts, posts: :user]
    end

    # Ensure that we can assign a user to the given post.

    defp assign_user(params, %{id: id}) do
        params
        |> assign_nested_struct("posts", "user_id", id, Map.keys(params["posts"]))
    end
end
