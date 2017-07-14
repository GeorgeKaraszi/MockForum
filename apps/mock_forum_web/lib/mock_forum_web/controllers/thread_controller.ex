defmodule MockForum.Web.ThreadController do
    @moduledoc """
        Access point for CRUDing threads
    """

    use MockForum.Web, :controller

    plug MockForum.Web.Plugs.RequireAuth when action in [:new, :create, :edit, :update]

    alias MockForum.{Thread, Category}

    def show(conn, %{"id" => thread_id}) do
        redirect(conn, to: thread_post_path(conn, :index, thread_id))
    end

    def new(conn, %{"category_id" => category_id}) do
        category  = Category.find!(category_id)
        changeset = Thread.new_thread
        render conn, "new.html", changeset: changeset, category: category
    end

    def create(conn, %{"category_id" => category_id, "thread" => thread_params}) do
        category = Category.find!(category_id)

        case Thread.create(category, conn.assigns.user, thread_params) do
            {:ok, thread} ->
                conn
                |> put_flash(:info, "successfully created a new thread")
                |> redirect(to: thread_post_path(conn, :index, thread))
            {:error, changeset} ->
                conn
                |> put_flash(:error, "Failed to create new thread")
                |> render("new.html", changeset: changeset, category: category)
        end
    end

    def update(conn, %{"category_id" => category_id, "id" => thread_id,  "thread" => thread}) do
        case Thread.update(category_id, thread) do
            {:ok, _thread} ->
                conn
                |> put_flash(:info, "successfully edited the thread")
                |> redirect(to: category_thread_path(conn, :show, category_id, thread_id))
            {:error, changeset} ->
                conn
                |> put_flash(:error, "There was an error with editing this thread")
                |> render("edit.html", changeset: changeset, category: category_id)
        end
    end

    def delete(conn, %{"category_id" => category_id, "id" => thread_id}) do
        Thread.delete!(thread_id)

        conn
        |> put_flash(:info, "Successfully deleted the thread")
        |> redirect(to: category_path(conn, :show, category_id))
    end
end
