defmodule MockForum.Web.Factory do
  @moduledoc false
  # with Ecto
  use ExMachina.Ecto, repo: MockForum.Repo
  use MockForum.Web.SubjectFactory
end
