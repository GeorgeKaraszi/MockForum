defmodule MockForum.Web.ThreadController do
    @moduledoc """
        Access point for CRUDing threads
    """

    use MockForum.Web, :controller
    
    alias MockForum.Commands.{ThreadCommands, SubjectCommands}

    def index(conn, _params) do
        render conn, "index.html", subjects: ThreadCommands.all
    end

    def show(conn, %{"subject_id" => subject_id, "id" => thread_id}) do
        render conn, "show.html", subject: subject_id, thread: ThreadCommands.find!(thread_id)
    end

    def new(conn, %{"subject_id" => subject_id}) do
        subject   = SubjectCommands.find(subject_id)
        changeset = ThreadCommands.changeset
        render conn, "new.html", changeset: changeset, subject: subject
    end

    def create(conn, %{"subject_id" => subject_id, "thread" => thread_params}) do
        subject = SubjectCommands.find(subject_id)

        case ThreadCommands.create(subject, thread_params) do
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

    def edit(conn, %{"subject_id" => subject_id, "id" => thread_id}) do
        thread    = ThreadCommands.find(thread_id)
        changeset = ThreadCommands.changeset(thread)

        render conn, "edit.html", changeset: changeset, thread: thread, subject: subject_id
    end

    def update(conn, %{"subject_id" => subject_id, "id" => thread_id,  "thread" => thread}) do
        case ThreadCommands.update(thread_id, thread) do
            {:ok, _thread} ->
                conn
                |> put_flash(:info, "successfully edited the subject")
                |> redirect(to: thread_path(conn, :show, subject_id, thread_id))
            {:error, changeset} ->
                conn
                |> put_flash(:error, "There was an error with editing this subject")
                |> render("edit.html", changeset: changeset, subject: subject_id)
        end
    end

    def delete(conn, %{"subject_id" => subject_id, "id" => thread_id}) do  
        ThreadCommands.delete!(thread_id)

        conn
        |> put_flash(:info, "Successfully deleted the subject")
        |> redirect(to: subject_path(conn, :show, subject_id))
    end
end
