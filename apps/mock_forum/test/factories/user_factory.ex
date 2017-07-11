defmodule MockForum.UserFactory do
    @moduledoc false
  alias Faker.{Internet, Name}

  defmacro __using__(_opts) do
    quote do
      def user_factory do
        %MockForum.User{
          first_name: Name.first_name,
          last_name: Name.last_name,
          email: Internet.email,
          token: "ABC123",
          provider: "github"
        }
      end
    end
  end
end
