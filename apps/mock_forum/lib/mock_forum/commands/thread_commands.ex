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


    # This is a very dirty method for assign the user to the new thread's inital post
    # I am looking for a more cleaner method to fix this nested struct mess!

    defp assign_user(params, user) do
        set_user = Map.put(params["posts"]["0"], "user_id", user.id)
        set_post = Map.put(params["posts"], "0", set_user)
        Map.put(params, "posts", set_post)
    end
end
