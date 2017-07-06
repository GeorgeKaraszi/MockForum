defmodule MockForum.Web.PageController do
  use MockForum.Web, :controller

  alias MockForum.Category

  def index(conn, _params) do
    categories = Repo.all(Category.preview_latest_threads)
    render conn, "index.html", categories: categories
  end
end
