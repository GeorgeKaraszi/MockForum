defmodule MockForum.Web.SubjectFactory do
    @moduledoc false
  defmacro __using__(_opts) do
    quote do
      def subject_factory do
        %MockForum.Subject{
          title: "My awesome subject",
          description: "Still working on it!",
          category: build(:category)
        }
      end
    end
  end
end
