defmodule MockForum.Web.Helper.DateHelpers do
    @moduledoc false
    use Timex

    def format_time_standard(timestamp) do
        timestamp
        |> convert_to_datetime
        |> Timex.format!("%Y-%m-%d", :strftime)
    end

    def convert_to_datetime(time) do
        case Timex.to_datetime(time) do
            {:error, _} ->
                time
            date_time ->
                date_time
        end
    end
end
