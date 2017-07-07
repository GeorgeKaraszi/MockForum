defmodule MockForum.User do
    @moduledoc false

    use MockForum, :model
    use MockForum.Commands.CrudCommands,
        record_type:  User,
        associations: [:posts]

    schema "users" do
        field :first_name, :string
        field :last_name, :string
        field :email, :string
        field :token, :string
        field :provider, :string

        has_many :posts, MockForum.Post, on_delete: :delete_all

        timestamps()
    end

    def changeset(struct \\ %User{}, params \\ %{}) do
        struct
        |> cast(params, [:email, :token, :first_name, :last_name, :provider])
        |> validate_required([:email, :token, :first_name])
    end
end
