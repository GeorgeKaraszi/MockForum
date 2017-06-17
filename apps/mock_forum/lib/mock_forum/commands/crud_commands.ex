defmodule MockForum.Commands.CrudCommands do
    @moduledoc """
        Macro for creating reusable CRUD commands that can be included to each set of schema commands
    """
    alias MockForum.Repo

    defmacro __using__(record_schema: record_schema, record_type: record_type, associations: associations) do
        quote do
               def all(preload),               do: Repo.all from s in unquote(record_type), preload: unquote(associations)
               def all,                        do: Repo.all(unquote(record_type))
               def find(record_id, :preload),  do: record_id |> find()  |> Repo.preload(unquote(associations))
               def find(record_id),            do: unquote(record_type) |> Repo.get(record_id)
               def find!(record_id, :preload), do: record_id |> find! |> Repo.preload(unquote(associations))
               def find!(record_id),           do: unquote(record_type) |> Repo.get!(record_id)
               def delete!(record_id),         do: record_id |> find! |> Repo.delete!
               
               def update(old_record_id, record) do
                   unquote(record_type)
                    |> Repo.get(old_record_id)
                    |> changeset(record)
                    |> Repo.update
                end

                def changeset(record \\ unquote(record_schema), record_params \\ %{}) do
                    record_type = unquote(record_type)
                    record |> record_type.changeset(record_params)
                end
        end
    end
    
end