defmodule MockForum.ThreadFactory do
    @moduledoc false
  alias Faker.Company

  defmacro __using__(_opts) do
    quote do
      def thread_factory do
        %MockForum.Thread{
          title: Company.bs,
          category: build(:category)
        }
      end

      def with_post(%MockForum.Thread{} = thread) do
        insert(:post, thread: thread)
        thread
      end

      def with_posts([]), do: []
      def with_posts([thread | threads]) do
        insert(:post, thread: thread)
        [thread | with_posts(threads)]
      end
    end
  end
end
