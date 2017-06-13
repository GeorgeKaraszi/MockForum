ExUnit.start()

Ecto.Adapters.SQL.Sandbox.mode(MockForum.Repo, :manual)

{:ok, _} = Application.ensure_all_started(:wallaby)

Application.put_env(:wallaby, :base_url, MockForum.Web.Endpoint.url)
Application.put_env(:wallaby, :screenshot_on_failure, true)

