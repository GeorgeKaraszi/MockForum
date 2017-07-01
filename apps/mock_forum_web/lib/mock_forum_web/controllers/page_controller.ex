defmodule MockForum.Web.PageController do
  use MockForum.Web, :controller

  alias MockForum.Category

  def index(conn, _params) do
    render conn, "index.html", categories: Category.all(true)
  end
end
