defmodule MockForum.Category do
    @moduledoc false

    use MockForum, :model
    use MockForum.Commands.CrudCommands,
        record_type:  Category,
        associations: [:threads]

    schema "categories" do
        has_many :threads, MockForum.Thread, on_delete: :delete_all
        has_many :thread_posts, through: [:threads, :posts], on_delete: :delete_all

        field :title, :string
        field :description, :string

        # Virtual / Decorator fields
        field :latest_thread, :string, virtual: true

        timestamps()
    end

    def changeset(struct \\ %Category{}, params \\ %{}) do
        struct
        |> cast(params, [:title, :description])
        |> validate_required([:title])
    end

    def create(category) do
        %Category{} |> changeset(category) |> Repo.insert
    end

    def order_by_latest_threads(%{id: category_id}), do: order_by_latest_threads(category_id)
    def order_by_latest_threads(category_id) do
        from s in Category,
        left_join: t in assoc(s, :threads),
        left_join: p in assoc(t, :posts),
        where: [id: ^category_id],
        order_by: [desc: p.inserted_at],
        preload: [threads: {t, posts: ^Post.latest_posts}]
    end

    def latest_unqiue_threads do
        thread = from(t in Thread.latest_threads, distinct: :category_id)
        from(s in Category, preload: [threads: ^thread])
    end

    # def preview_latest_threads do
    #     from c in Category, preload: [subjects: ^Subject.latest_unqiue_threads]
    # end
end
