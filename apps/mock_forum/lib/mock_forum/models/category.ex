defmodule MockForum.Category do
    @moduledoc false

    use MockForum, :model
    use MockForum.Commands.CrudCommands, 
        record_type:  Category,
        associations: [:subjects]

    schema "categories" do
        field :title, :string
        has_many :subjects, MockForum.Subject

        timestamps()
    end

    def changeset(struct \\ %Category{}, params \\ %{}) do
        struct
        |> cast(params, [:title])
        |> validate_required([:title])
    end

    def create(category_params) do
     %Category{} |> changeset(category_params) |> Repo.insert
    end
end
