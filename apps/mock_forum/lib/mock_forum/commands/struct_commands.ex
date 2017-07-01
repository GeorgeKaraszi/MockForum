defmodule MockForum.Commands.StructCommands do
    @moduledoc """
        Used for creating reusable useful struct/map commands to modify or update an existing element
    """
    def assign_nested_struct(params, _access_key, _key, _value, []), do: params
    def assign_nested_struct(params, access_key, key, value, [index | index_tail]) do
        params[access_key][index][key]
        |> put_in(value)
        |> assign_nested_struct(access_key, key, value, index_tail)
    end
end