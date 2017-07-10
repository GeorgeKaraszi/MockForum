defmodule MockForum.ThreadFactory do
    @moduledoc false
  defmacro __using__(_opts) do
    quote do
      def thread_factory do
        %MockForum.Thread{
          title: "My awesome thread title",
          subject: build(:subject)
        }
      end
    end
  end
end
