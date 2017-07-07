defmodule MockForum.Web.CategoryController do
    @moduledoc """
        Access point for CRUDing subjects
    """

    use MockForum.Web, :controller

    alias MockForum.Category

    def index(conn, _params) do
        redirect(conn, to: page_path(conn, :index))
    end

    def show(conn, %{"id" => category_id}) do
        render conn, "show.html", category: Category.find!(category_id, :preload)
    end

    def new(conn, _params) do
        render conn, "new.html", changeset: Category.changeset
    end

    def create(conn, %{"category" => category_params}) do
        case Category.create(category_params) do
            {:ok, _subject} ->
                conn
                |> put_flash(:info, "successfully created a new category")
                |> redirect(to: page_path(conn, :index))
            {:error, changeset} ->
                conn
                |> put_flash(:error, "Failed to create new category")
                |> render("new.html", changeset: changeset)
        end
    end

    def edit(conn, %{"id" => category_id}) do
        category   = Category.find(category_id)
        changeset  = Category.changeset(category)

        render conn, "edit.html", changeset: changeset, category: category
    end

    def update(conn, %{"id" => category_id, "category" => category}) do
        case Category.update(category_id, category) do
            {:ok, _category} ->
                conn
                |> put_flash(:info, "successfully edited the category")
                |> redirect(to: page_path(conn, :index))
            {:error, changeset} ->
                conn
                |> put_flash(:error, "There was an error with editing this category")
                |> render("edit.html", changeset: changeset, category: category)
        end
    end

    def delete(conn, %{"id" => category_id}) do
        Category.delete!(category_id)

        conn
        |> put_flash(:info, "Successfully deleted the category")
        |> redirect(to: page_path(conn, :index))
    end
end
