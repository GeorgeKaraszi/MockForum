defmodule MockForum.Web.Plugs.RequireAuth do
    @moduledoc """
        Checks to see if the user has been assigned to the connection. 
        If not, it will redirect back to the root page with an error message.
    """
    import Plug.Conn
    import Phoenix.Controller

    alias MockForum.Router.Helpers

    def init(_params) do
        
    end

    def call(conn, _params) do
        if conn.assigns[:user] do
            conn
        else
            conn
            |> put_flash(:error, "You must be logged in")
            |> redirect(to: Helpers.page_path(conn, :index))
            |> halt()
        end
    end
    
end