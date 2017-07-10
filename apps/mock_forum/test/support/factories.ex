defmodule MockForum.Factory do
  @moduledoc false
  # with Ecto
  use ExMachina.Ecto, repo: MockForum.Repo
  use MockForum.SubjectFactory
  use MockForum.ThreadFactory
  use MockForum.PostFactory
  use MockForum.UserFactory
  use MockForum.CategoryFactory
end
