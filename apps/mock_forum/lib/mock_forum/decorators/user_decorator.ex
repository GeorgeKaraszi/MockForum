defmodule MockForum.UserDecorator do
    @moduledoc """
        Decorates the user object with extra attributes that contribute to the overall
        experince of the application
    """
    use MockForum, :model

    def decorate(user) do
        user
        |> profile_name
        |> post_count
        |> provider
    end

    defp profile_name(user) do
        first_name   = String.capitalize(user.first_name)
        last_name    = user.last_name |> String.at(0) |> String.capitalize
        profile_name =
            if last_name do
                "#{first_name} #{last_name}."
            else
                "#{first_name}"
            end

        %User{user | profile_name: profile_name}
    end

    defp post_count(user) do
        query      = from p in Post, where: [user_id: ^user.id]
        post_count = Repo.aggregate(query, :count, :id)

        %User{user | post_count: post_count}
    end

    defp provider(user) do
        %User{user | provider: String.capitalize(user.provider)}
    end

end
