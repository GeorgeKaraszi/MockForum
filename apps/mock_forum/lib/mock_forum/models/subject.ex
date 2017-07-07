defmodule MockForum.Subject do
    @moduledoc false

    use MockForum, :model
    use MockForum.Commands.CrudCommands,
        record_type:  Subject,
        associations: [:threads]

    schema "subjects" do
        belongs_to :category, MockForum.Category
        has_many :threads, MockForum.Thread, on_delete: :delete_all

        field :title, :string
        field :description, :string

        timestamps()
    end

    def changeset(struct \\ %Subject{}, params \\ %{}) do
        struct
        |> cast(params, [:title, :description, :category_id])
        |> cast_assoc(:category)
        |> validate_required([:title])
    end

    def new_subject(category_id) do
        changeset(%Subject{}, %{category_id: category_id})
    end

    def create(subject) do
        %Subject{} |> changeset(subject) |> Repo.insert
    end

    def order_by_latest_threads(subject_id) do
        from s in Subject,
        left_join: t in assoc(s, :threads),
        left_join: p in assoc(t, :posts),
        where: [id: ^subject_id],
        order_by: [desc: p.inserted_at],
        preload: [threads: {t, posts: ^Post.latest_posts}]
    end

    def latest_unqiue_threads do
        thread = from(t in Thread.latest_threads, distinct: :subject_id)
        from(s in Subject, preload: [threads: ^thread])
    end
end
