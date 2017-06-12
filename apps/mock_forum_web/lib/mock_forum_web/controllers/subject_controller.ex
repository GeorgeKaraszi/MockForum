defmodule MockForum.Web.SubjectController do
    @moduledoc """
        Access point for CRUDing subjects
    """

    use MockForum.Web, :controller

    alias MockForum.Commands.SubjectCommands

    def index(conn, _params) do
        render conn, "index.html", subjects: SubjectCommands.all
    end

    def new(conn, _params) do
        render conn, "new.html", changeset: SubjectCommands.changeset
    end

    def create(conn, %{"subject" => subject_params}) do
        case SubjectCommands.create(subject_params) do
            {:ok, _subject} ->
                conn
                |> put_flash(:info, "successfully created a new subject")
                |> redirect(to: page_path(conn, :index))
            {:error, changeset} ->
                conn
                |> put_flash(:error, "Failed to create new subject")
                |> render("new.html", changeset: changeset)
        end
    end

    def edit(conn, %{"id" => subject_id}) do
        subject   = SubjectCommands.find(subject_id)
        changeset = SubjectCommands.changeset(subject)

        render conn, "edit.html", changeset: changeset, subject: subject
    end

    def update(conn, %{"id" => subject_id, "subject" => subject}) do
        case SubjectCommands.update(subject_id, subject) do
            {:ok, _subject} ->
                conn
                |> put_flash(:info, "successfully edited the subject")
                |> redirect(to: page_path(conn, :index))
            {:error, changeset} ->
                conn
                |> put_flash(:error, "There was an error with editing this subject")
                |> render("edit.html", changeset: changeset, subject: subject)
        end
    end

    def delete(conn, %{"id" => subject_id}) do  
        SubjectCommands.delete!(subject_id)

        conn
        |> put_flash(:info, "Successfully deleted the subject")
        |> redirect(to: page_path(conn, :index))
    end
end
