defmodule MockForum.Commands.SubjectCommands do
    @moduledoc """
        Commands used to create forum subjects
    """
    use MockForum, :commands
    use MockForum.Commands.CrudCommands, 
        record_schema:  %Subject{}, 
        record_type: Subject, 
        associations: [:threads]

    def create(subject) do
        %Subject{} |> changeset(subject) |> Repo.insert
    end
end
