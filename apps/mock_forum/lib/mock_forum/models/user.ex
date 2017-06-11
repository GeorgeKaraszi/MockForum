defmodule MockForum.User do
    @moduledoc false
    
    use MockForum, :model

    schema "users" do
        field :first_name, :string
        field :last_name, :string
        field :email, :string
        field :token, :string
        field :provider, :string

        timestamps()
    end

    def changeset(struct, params \\ %{}) do
        struct
        |> cast(params, [:email, :token, :first_name, :last_name, :provider])
        |> validate_required([:email, :token, :first_name])
    end
end