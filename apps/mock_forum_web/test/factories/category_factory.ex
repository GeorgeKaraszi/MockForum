defmodule MockForum.Web.CategoryFactory do
    @moduledoc false
  defmacro __using__(_opts) do
    quote do
      def category_factory do
        %MockForum.Category{
          title: "My awesome Category"
        }
      end
    end
  end
end
