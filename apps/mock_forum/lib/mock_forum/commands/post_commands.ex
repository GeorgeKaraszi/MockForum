defmodule MockForum.Commands.PostCommands do
    @moduledoc """
        Commands used to create forum threads that are assoicated with post hread parent
    """
    use MockForum, :commands
    use MockForum.Commands.CrudCommands, 
        record_schema:  %Post{}, 
        record_type: Post, 
        associations: []

    def create(thread, thread_params) do
        thread |> build_assoc(:posts) |> changeset(thread_params) |> Repo.insert
    end
end
