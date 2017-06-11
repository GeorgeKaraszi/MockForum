use Mix.Config

# Configure your database
config :mock_forum, MockForum.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "password",
  database: "mock_forum_dev",
  hostname: "localhost",
  pool_size: 10
