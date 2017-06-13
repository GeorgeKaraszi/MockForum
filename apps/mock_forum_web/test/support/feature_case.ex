defmodule MockForum.Web.FeatureCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use Wallaby.DSL

      alias MockForum.Repo
      import Ecto
      import Ecto.Changeset
      import Ecto.Query

      import MockForum.Web.Router.Helpers
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(MockForum.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(MockForum.Repo, {:shared, self()})
    end

    metadata = Phoenix.Ecto.SQL.Sandbox.metadata_for(MockForum.Repo, self())
    {:ok, session} = Wallaby.start_session(metadata: metadata)
    {:ok, session: session}
  end
end