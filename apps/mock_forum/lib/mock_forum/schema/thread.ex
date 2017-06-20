defmodule MockForum.Thread do
    @moduledoc false

    use MockForum, :model

    schema "threads" do
        belongs_to :subject, MockForum.Subject
        field :title, :string

        has_many :posts, MockForum.Post, on_delete: :delete_all 

        timestamps()
    end

    def changeset(struct, params \\ %{}) do
        struct
        |> cast(params, [:title, :subject_id])
        |> cast_assoc(:subject)
        |> cast_assoc(:posts)
        |> validate_required([:title])
    end
end
