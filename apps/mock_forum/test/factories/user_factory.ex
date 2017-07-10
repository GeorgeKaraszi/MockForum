defmodule MockForum.UserFactory do
    @moduledoc false
  defmacro __using__(_opts) do
    quote do
      def user_factory do
        %MockForum.User{
          first_name: "Example",
          last_name: "User",
          email: "user@example.com",
          token: "ABC123",
          provider: "github"
        }
      end
    end
  end
end
