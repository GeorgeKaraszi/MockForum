defmodule MockForum.Web.ProfileController do
    @moduledoc """
        Access point for CRUDing posts
    """

    use MockForum.Web, :controller
    plug MockForum.Web.Plugs.RequireAuth

    alias MockForum.{User, UserDecorator}

    def profile(conn, %{"id" => user_id}) do
        user =
            user_id
            |> User.find!
            |> UserDecorator.decorate

        render(conn, "profile.html", user: user)
    end

    def show(conn, _params) do
        user = UserDecorator.decorate(conn.assigns.user)
        render conn, "show.html", user: user
    end

    def edit(conn, _params) do
        changeset = User.changeset(conn.assigns.user)
        render conn, "edit.html", changeset: changeset
    end

    def update(conn, %{"user" => user}) do
        case User.update(conn.assigns.user.id, user) do
            {:ok, _user} ->
                conn
                |> put_flash(:info, "Successfully updated your profile")
                |> redirect(to: profile_path(conn, :show))
            {:error, changeset} ->
                conn
                |> put_flash(:error, "There was an error with editing your profile")
                |> render("edit.html", changeset: changeset)
        end
    end
end
