defmodule MockForum.Web.SubjectController do
    @moduledoc """
        Access point for CRUDing subjects
    """

    use MockForum.Web, :controller

    alias MockForum.Subject

    def index(conn, _params) do
        render conn, "index.html", subjects: Subject.all(true)
    end

    def show(conn, %{"id" => subject_id}) do
        subject =
            subject_id
            |> Subject.order_by_latest_threads
            |> Repo.one!
        render conn, "show.html", subject: subject
    end

    def new(conn, %{"category_id" => category_id}) do
        render conn, "new.html", changeset: Subject.new_subject(category_id)
    end

    def create(conn, %{"subject" => subject_params}) do
        case Subject.create(subject_params) do
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
        subject   = Subject.find!(subject_id)
        changeset = Subject.changeset(subject)

        render conn, "edit.html", changeset: changeset, subject: subject
    end

    def update(conn, %{"id" => subject_id, "subject" => subject}) do
        case Subject.update(subject_id, subject) do
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
        Subject.delete!(subject_id)

        conn
        |> put_flash(:info, "Successfully deleted the subject")
        |> redirect(to: page_path(conn, :index))
    end
end
