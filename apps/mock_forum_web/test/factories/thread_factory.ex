defmodule MockForum.Web.ThreadFactory do
    @moduledoc false
  defmacro __using__(_opts) do
    quote do
      def thread_factory do
        %MockForum.Thread{
          title: "My awesome subject",
          subject: build(:subject)
        }
      end
    end
  end
end
