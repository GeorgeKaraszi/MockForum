defmodule MockForum.PostFactory do
    @moduledoc false
  alias Faker.Company

  defmacro __using__(_opts) do
    quote do
      def post_factory do
        %MockForum.Post{
          message: Company.bullshit,
          thread: build(:thread),
          user: build(:user)
        }
      end
    end
  end
end
