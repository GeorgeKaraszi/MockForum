defmodule MockForum.Web.PageController do
  use MockForum.Web, :controller

  alias MockForum.{Category, CategoryDecorator}

  def index(conn, _params) do
    categories = Repo.all(Category.latest_unqiue_threads)
    render conn, "index.html", categories: CategoryDecorator.decorates(categories)
  end
end
