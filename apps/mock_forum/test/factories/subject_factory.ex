defmodule MockForum.SubjectFactory do
    @moduledoc false

    alias Faker.Company
  defmacro __using__(_opts) do
    quote do
      def subject_factory do
        %MockForum.Subject{
          title: Company.name,
          description: Company.catch_phrase,
          category: build(:category)
        }
      end
    end
  end
end
