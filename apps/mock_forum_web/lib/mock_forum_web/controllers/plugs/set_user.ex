defmodule MockForum.Web.Plugs.SetUser do
    @moduledoc """
        Once the user has signin, assign the user object to the connection. 
        Otherwise set it to nil if no user is signed in.
    """
    import Plug.Conn
    import Phoenix.Controller

    alias MockForum.Repo
    alias MockForum.User

    def init(_params) do
    end

    # Assigns the user object to connection if the user has signed in
    def call(conn, _params) do
        user_id = get_session(conn, :user_id)
        user    = if user_id, do: Repo.get(User, user_id), else: nil
        assign(conn, :user, user)
    end
end
