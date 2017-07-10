defmodule MockForum.Web.AuthController do
    @moduledoc """
        Handel's all OAuth connection callbacks from github.
    """
    use MockForum.Web, :controller
    plug Ueberauth

    alias MockForum.User
    alias MockForum.Repo

    def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do

        [first_name, last_name] = extract_name(auth)
        user_params = %{
            first_name: first_name,
            last_name: last_name,
            token: auth.credentials.token,
            email: auth.info.email,
            provider: "github"
        }

        changeset = User.changeset(%User{}, user_params)
        signin(conn, changeset)
    end

    def signout(conn, _params) do
        conn
        |> configure_session(drop: true)
        |> put_flash(:info, "Sucessfully logged out!")
        |> redirect(to: page_path(conn, :index))
    end

    defp signin(conn, changeset) do
        case update_or_insert_user(changeset) do
            {:ok, user} ->
                conn
                |> put_session(:user_id, user.id)
                |> put_flash(:info, "Successfully logged in")
                |> redirect(to: page_path(conn, :index))

            {:error, _reason} ->
                conn
                |> put_flash(:error, "failed to log in")
                |> redirect(to: page_path(conn, :index))
        end
    end

    defp update_or_insert_user(changeset) do
        case User.find_by(email: changeset.changes.email) do
            nil ->
                Repo.insert(changeset)
            user ->
                {:ok, user}
        end
    end

    defp extract_name(%{info: info}) do
       users_name = String.split(info.name, " ")
       first_name = List.first(users_name)
       last_name  = if Enum.count(users_name) > 1, do: List.last(users_name), else: nil
       [first_name, last_name]
    end
end
