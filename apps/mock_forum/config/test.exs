use Mix.Config

# Configure your database
config :mock_forum, MockForum.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "mock_forum_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
