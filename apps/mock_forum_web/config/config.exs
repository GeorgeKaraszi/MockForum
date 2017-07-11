# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :mock_forum_web,
  namespace: MockForum.Web,
  ecto_repos: [MockForum.Repo]

# Configures the endpoint
config :mock_forum_web, MockForum.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "YxCFhj1+Uwheg3rhQUQa2AlKaDy+pBT4tQBHH4W60j2Ja5PBWWCxhK/4W43/ev4/",
  render_errors: [view: MockForum.Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: MockForum.Web.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :mock_forum_web, :generators,
  context_app: :mock_forum

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

config :ueberauth, Ueberauth,
  providers: [
    github: {Ueberauth.Strategy.Github, []}
  ]

config :ueberauth, Ueberauth.Strategy.Github.OAuth,
  client_id: System.get_env("GITHUB_CLIENT_ID"),
  client_secret: System.get_env("GITHUB_CLIENT_SECRET")

config :ex_aws,
  access_key_id: System.get_env("AWS_ACCESS_KEY_ID"),
  secret_access_key: System.get_env("AWS_SECRET_ACCESS_KEY")

config :arc,
  storage: Arc.Storage.S3, # or Arc.Storage.Local
  bucket: System.get_env("AWS_BUCKET_NAME"),
  virtual_host: true
