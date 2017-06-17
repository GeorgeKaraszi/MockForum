defmodule MockForum.Web.Router do
  use MockForum.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug MockForum.Web.Plugs.SetUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MockForum.Web do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/subject", SubjectController
  end

  scope "/subject/:subject_id", MockForum.Web do
    pipe_through :browser
    resources "/thread", ThreadController
  end

  scope "/auth", MockForum.Web do
    pipe_through :browser
    
    get "/signout", AuthController, :signout
    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
  end
  # Other scopes may use custom stacks.
  # scope "/api", MockForum.Web do
  #   pipe_through :api
  # end
end
