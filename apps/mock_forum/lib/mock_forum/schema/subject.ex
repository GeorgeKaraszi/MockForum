defmodule MockForum.Subject do
    @moduledoc false

    use MockForum, :model

    schema "subjects" do
        field :title, :string
        field :description, :string

        timestamps()
    end

    def changeset(struct, params \\ %{}) do
        struct
        |> cast(params, [:title, :description])
        |> validate_required([:title])
    end
end
