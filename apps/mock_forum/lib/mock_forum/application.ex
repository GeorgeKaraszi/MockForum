defmodule MockForum.Application do
  @moduledoc """
  The MockForum Application Service.

  The mock_forum system business domain lives in this application.

  Exposes API to clients such as the `MockForum.Web` application
  for use in channels, controllers, and elsewhere.
  """
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    Supervisor.start_link([
      supervisor(MockForum.Repo, []),
    ], strategy: :one_for_one, name: MockForum.Supervisor)
  end
end
