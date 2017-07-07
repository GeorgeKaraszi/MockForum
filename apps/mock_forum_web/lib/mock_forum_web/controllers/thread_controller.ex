defmodule MockForum.Web.ThreadController do
    @moduledoc """
        Access point for CRUDing threads
    """

    use MockForum.Web, :controller

    plug MockForum.Web.Plugs.RequireAuth when action in [:new, :create, :edit, :update]

    alias MockForum.{Thread, Subject}

    def index(conn, _params) do
        render conn, "index.html", subjects: Thread.all
    end

    def show(conn, %{"id" => thread_id}) do
        redirect(conn, to: thread_post_path(conn, :index, thread_id))
    end

    def new(conn, %{"subject_id" => subject_id}) do
        subject   = Subject.find(subject_id)
        changeset = Thread.new_thread
        render conn, "new.html", changeset: changeset, subject: subject
    end

    def create(conn, %{"subject_id" => subject_id, "thread" => thread_params}) do
        subject = Subject.find(subject_id)

        case Thread.create(subject, conn.assigns.user, thread_params) do
            {:ok, _thread} ->
                conn
                |> put_flash(:info, "successfully created a new thread")
                |> redirect(to: subject_path(conn, :show, subject))
            {:error, changeset} ->
                conn
                |> put_flash(:error, "Failed to create new thread")
                |> render("new.html", changeset: changeset, subject: subject)
        end
    end

    def update(conn, %{"subject_id" => subject_id, "id" => thread_id,  "thread" => thread}) do
        case Thread.update(thread_id, thread) do
            {:ok, _thread} ->
                conn
                |> put_flash(:info, "successfully edited the thread")
                |> redirect(to: subject_thread_path(conn, :show, subject_id, thread_id))
            {:error, changeset} ->
                conn
                |> put_flash(:error, "There was an error with editing this thread")
                |> render("edit.html", changeset: changeset, subject: subject_id)
        end
    end

    def delete(conn, %{"subject_id" => subject_id, "id" => thread_id}) do
        Thread.delete!(thread_id)

        conn
        |> put_flash(:info, "Successfully deleted the thread")
        |> redirect(to: subject_path(conn, :show, subject_id))
    end
end
