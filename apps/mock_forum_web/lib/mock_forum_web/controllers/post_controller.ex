defmodule MockForum.Web.PostController do
    @moduledoc """
        Access point for CRUDing posts
    """

    use MockForum.Web, :controller
    plug MockForum.Web.Plugs.RequireAuth when action in [:new, :create, :edit, :update]
    
    alias MockForum.Commands.{ThreadCommands, PostCommands}

    def index(conn, %{"thread_id" => thread_id}) do
        thread = ThreadCommands.find(thread_id, :preload)
        posts  = thread.posts
        render conn, "index.html", thread: thread, posts: posts
    end

    def new(conn, %{"thread_id" => thread_id}) do
        changeset = PostCommands.changeset
        render conn, "new.html", changeset: changeset, thread: thread_id
    end

    def create(conn, %{"thread_id" => thread_id, "post" => post_params}) do
        thread = ThreadCommands.find!(thread_id)
        case PostCommands.create(thread, conn.assigns[:user], post_params) do
            {:ok, _post} ->
                conn
                |> put_flash(:info, "Successfully posted!")
                |> redirect(to: thread_post_path(conn, :index, thread))
            {:error, changeset} ->
                conn
                |> put_flash(:error, "An error has occured while creating your post")
                |> render("new.html", changeset: changeset, thread: thread)
        end
    end

    def edit(conn, %{"thread_id" => thread_id, "id" => post_id}) do
        post      = PostCommands.find(post_id)
        changeset = PostCommands.changeset(post)

        render conn, "edit.html", changeset: changeset, post: post, thread: thread_id
    end

    def update(conn, %{"thread_id" => thread_id, "id" => post_id,  "post" => post}) do
        case PostCommands.update(post_id, post) do
            {:ok, _post} ->
                conn
                |> put_flash(:info, "Successfully updated your post")
                |> redirect(to: thread_post_path(conn, :index, thread_id))
            {:error, changeset} ->
                conn
                |> put_flash(:error, "There was an error with editing this post")
                |> render("edit.html", changeset: changeset, thread: thread_id)
        end
    end

    def delete(conn, %{"thread_id" => thread_id, "id" => post_id}) do
        PostCommands.delete!(post_id)

        conn
        |> put_flash(:info, "Successfully deleted the post")
        |> redirect(to: thread_post_path(conn, :index, thread_id))
    end
end
