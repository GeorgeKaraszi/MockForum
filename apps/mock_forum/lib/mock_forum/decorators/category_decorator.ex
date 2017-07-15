defmodule MockForum.CategoryDecorator do
    @moduledoc """
        Decorates the user object with extra attributes that contribute to the overall
        experince of the application
    """
    use MockForum, :model

    alias MockForum.ThreadDecorator

    def decorates([]), do: []
    def decorates([category | categories]), do: [decorate(category) | decorates(categories)]
    def decorate(category) do
        category
        |> decorate_threads
        |> latest_thread
    end

    defp decorate_threads(%Category{threads: threads} = category) do
        %Category{category | threads: ThreadDecorator.decorates(threads)}
    end

    defp latest_thread(%Category{threads: threads} = category) do
        %Category{category | latest_thread: List.first(threads)}
    end
end
