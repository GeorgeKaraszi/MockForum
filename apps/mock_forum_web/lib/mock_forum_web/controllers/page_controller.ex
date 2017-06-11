defmodule MockForum.Web.PageController do
  use MockForum.Web, :controller

  # plug MockForum.Web.Plugs.RequireAuth when action in [:create]

  def index(conn, _params) do
    render conn, "index.html"
  end
end
