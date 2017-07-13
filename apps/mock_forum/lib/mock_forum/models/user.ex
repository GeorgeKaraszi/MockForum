defmodule MockForum.User do
    @moduledoc false

    use Arc.Ecto.Schema
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
        field :avatar, Avatar.Type

        # Virtual / Decorator fields
        field :profile_name, :string, virtual: true
        field :post_count, :integer, virtual: true

        has_many :posts, MockForum.Post, on_delete: :delete_all

        timestamps()
    end

    def changeset(struct \\ %User{}, params \\ %{}) do
        struct
        |> cast(params, [:email, :token, :first_name, :last_name, :provider])
        |> cast_attachments(params, [:avatar])
        |> validate_required([:email, :token, :first_name])
    end
end
