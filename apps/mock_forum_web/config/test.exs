use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :mock_forum_web, MockForum.Web.Endpoint,
  http: [port: 4001],
  server: true

config :mock_forum_web, :sql_sandbox, true
config :wallaby, screenshot_dir: "../../tmp/screenshots"
