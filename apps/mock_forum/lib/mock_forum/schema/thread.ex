defmodule MockForum.Thread do
    @moduledoc false

    use MockForum, :model

    schema "threads" do
        belongs_to :subject, MockForum.Subject
        field :title, :string

        timestamps()
    end

    def changeset(struct, params \\ %{}) do
        struct
        |> cast(params, [:title, :subject_id])
        |> cast_assoc(:subject)
        |> validate_required([:title])
    end
end
