defmodule MockForum.Web.PageController do
  use MockForum.Web, :controller

  # plug MockForum.Web.Plugs.RequireAuth when action in [:create]

  alias MockForum.Commands.SubjectCommands

  def index(conn, _params) do
    render conn, "index.html", subjects: SubjectCommands.all
  end
end
