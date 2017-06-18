defmodule MockForum.Commands.ThreadCommands do
    @moduledoc """
        Commands used to create forum threads that are assoicated with the Subject parent
    """
    use MockForum, :commands
    use MockForum.Commands.CrudCommands, 
        record_schema:  %Thread{}, 
        record_type: Thread, 
        associations: [:posts]

    def create(subject, thread_params) do
        subject |> build_assoc(:threads) |> changeset(thread_params) |> Repo.insert
    end
end
