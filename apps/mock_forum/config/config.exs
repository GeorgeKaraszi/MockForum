use Mix.Config

config :mock_forum, MockForum.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "mock_forum_repo",
  username: "user",
  password: "pass",
  hostname: "localhost"

config :mock_forum, ecto_repos: [MockForum.Repo]

import_config "#{Mix.env}.exs"
