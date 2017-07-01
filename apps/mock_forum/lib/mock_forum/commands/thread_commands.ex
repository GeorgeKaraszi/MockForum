defmodule MockForum.Commands.ThreadCommands do
    @moduledoc """
        Commands used to create forum threads that are assoicated with the Subject parent
    """
    use MockForum, :commands
    use MockForum.Commands.CrudCommands,
        record_schema:  %Thread{},
        record_type: Thread,
        associations: [posts: :user]

    alias MockForum.Commands.PostCommands

    def new_thread(record_params \\ %{}) do
        post = PostCommands.changeset
        changeset(%Thread{posts: [post]}, record_params)
    end

    def create(subject, user, thread_params) do
        thread_params = assign_user(thread_params, user)

        subject
        |> build_assoc(:threads)
        |> changeset(thread_params)
        |> Repo.insert
    end

    # Ensure that we can assign a user to the given post.

    defp assign_user(params, %{id: id} = user) do
        assign_nested_struct(params, "posts", "user_id", id, Map.keys(params["posts"]))
    end

    defp assign_nested_struct(params, _access_key, _key, _value, []), do: params
    defp assign_nested_struct(params, access_key, key, value, [index | index_tail]) do
        params[access_key][index][key]
        |> put_in(value)
        |> assign_nested_struct(access_key, key, value, index_tail)
    end
end
