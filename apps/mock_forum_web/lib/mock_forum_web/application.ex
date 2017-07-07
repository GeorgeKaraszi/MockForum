defmodule MockForum.Web.Application do
  @moduledoc false
  use Application

  alias Mix.Config

  def start(_type, _args) do
    unless Mix.env == :prod do
      Envy.auto_load
      # Re-run config for the DOT env files to load envirmental variables
      "config/config.exs" |> Config.read! |> Config.persist
    end

    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      # Start the endpoint when the application starts
      supervisor(MockForum.Web.Endpoint, []),
      # Start your own worker by calling:
      # MockForum.Web.Worker.start_link(arg1, arg2, arg3)
      # worker(MockForum.Web.Worker, [arg1, arg2, arg3]),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MockForum.Web.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
