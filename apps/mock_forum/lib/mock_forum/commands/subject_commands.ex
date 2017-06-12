defmodule MockForum.Commands.SubjectCommands do
    @moduledoc """
        Commands used to create forum subjects
    """
    use MockForum, :commands
   
   def all,                 do: Repo.all(Subject)
   def find(subject_id),    do: Repo.get(Subject, subject_id)
   def find!(subject_id),   do: Repo.get!(Subject, subject_id)
   def delete!(subject_id), do: subject_id |> find!() |> Repo.delete!

   def changeset(record \\ %Subject{}, record_params \\ %{}) do
       record |> Subject.changeset(record_params)
   end

    def create(subject) do
        %Subject{}
        |> changeset(subject)
        |> Repo.insert()
    end

    def update(old_subject_id, subject) do
        Subject
        |> Repo.get(old_subject_id)
        |> changeset(subject)
        |> Repo.update()
    end
end
