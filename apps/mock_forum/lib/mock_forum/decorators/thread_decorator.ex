defmodule MockForum.ThreadDecorator do
    @moduledoc """
        Decorates the user object with extra attributes that contribute to the overall
        experince of the application
    """
    use MockForum, :model

    def decorates([]), do: []
    def decorates([thread | threads]), do: [decorate(thread) | decorates(threads)]
    def decorate(thread), do: thread |> latest_post

    defp latest_post(thread) do
        latest_post = List.last(thread.posts)
        %Thread{thread | latest_post: latest_post}
    end
end
