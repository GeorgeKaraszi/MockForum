defmodule MockForum.Web.Mailbox.MessageCenterController do
    @moduledoc """
        Controlls how private messages are sent to other users
    """

    use MockForum.Web, :controller
    plug MockForum.Web.Plugs.RequireAuth

    alias MockForum.{User, Repo}
    def index(conn, _params) do

    end

    def show(conn, _params) do

    end

    def new(conn, %{"receipient_id" => receipient_id}) do
        render conn, "new.html", receipient: User.find!(receipient_id)
    end

    def create(conn, _params) do

    end
end
