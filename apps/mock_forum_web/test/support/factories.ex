defmodule MockForum.Web.Factory do
  @moduledoc false
  # with Ecto
  use ExMachina.Ecto, repo: MockForum.Repo
  use MockForum.Web.SubjectFactory
  use MockForum.Web.ThreadFactory
  use MockForum.Web.PostFactory
  use MockForum.Web.UserFactory
  use MockForum.Web.CategoryFactory
end
