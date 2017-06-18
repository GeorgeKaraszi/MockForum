defmodule MockForum.Web.PostFactory do
    @moduledoc false
  defmacro __using__(_opts) do
    quote do
      def post_factory do
        %MockForum.Post{
          message: "My awesome message",
          thread: build(:thread)
        }
      end
    end
  end
end
