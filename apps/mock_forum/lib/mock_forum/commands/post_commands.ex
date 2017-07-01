defmodule MockForum.Commands.PostCommands do
    @moduledoc """
        Commands used to create forum threads that are assoicated with post hread parent
    """
    use MockForum, :commands
    use MockForum.Commands.CrudCommands, 
        record_schema:  %Post{}, 
        record_type: Post, 
        associations: []

    def create(thread, user, post_params) do
     %Post{} 
        |> changeset(post_params) 
        |> change
        |> put_assoc(:user, user, required: true)
        |> put_assoc(:thread, thread, required: true)
        |> Repo.insert
    end
end
