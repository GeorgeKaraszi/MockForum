use Mix.Config

config :mock_forum, ecto_repos: [MockForum.Repo]

import_config "#{Mix.env}.exs"
