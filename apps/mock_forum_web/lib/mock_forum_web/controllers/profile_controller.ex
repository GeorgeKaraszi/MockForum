defmodule MockForum.Web.ProfileController do
    @moduledoc """
        Access point for CRUDing posts
    """

    use MockForum.Web, :controller
    plug MockForum.Web.Plugs.RequireAuth

    alias MockForum.{User, UserDecorator}

    def profile(conn, _params) do
        user = UserDecorator.decorate(conn.assigns.user)
        render conn, "profile.html", user: user
    end

    # def edit(conn, %{"thread_id" => thread_id, "id" => post_id}) do
    #     post      = Post.find(post_id)
    #     changeset = Post.changeset(post)

    #     render conn, "edit.html", changeset: changeset, post: post, thread: thread_id
    # end

    # def update(conn, %{"thread_id" => thread_id, "id" => post_id,  "post" => post}) do
    #     case Post.update(post_id, post) do
    #         {:ok, _post} ->
    #             conn
    #             |> put_flash(:info, "Successfully updated your post")
    #             |> redirect(to: thread_post_path(conn, :index, thread_id))
    #         {:error, changeset} ->
    #             conn
    #             |> put_flash(:error, "There was an error with editing this post")
    #             |> render("edit.html", changeset: changeset, thread: thread_id)
    #     end
    # end
end
