defmodule MockForum.CategoryFactory do

  @moduledoc false
  alias Faker.Company

  defmacro __using__(_opts) do
    quote do
      def category_factory do
        %MockForum.Category{
          title: Company.catch_phrase
        }
      end
    end
  end
end
