defmodule MockForum.Web.Feature.PostFeatureTest do
  use MockForum.Web.FeatureCase, async: true
  use Plug.Test

  alias Plug.Conn

  import MockForum.Web.Factory
  import Wallaby.Query, only: [text_field: 1, link: 1, button: 1, css: 2]

  @session Plug.Session.init(
    store: :cookie,
    key: "_app",
    encryption_salt: "yadayada",
    signing_salt: "yadayada"
  )

  #   setup do
  #     user = insert(:user)
  #     session_data = %{user_id: user.id}

  #     conn =
  #       conn(:get, "/")
  #       |> Map.put(:secret_key_base, String.duplicate("abcdefgh", 8))
  #       |> Plug.Session.call(@session)
  #       |> Conn.fetch_session()
  #     {:ok, conn: conn, user: user, session_data: session_data}
  # end

  describe "Creating a new post" do
    test "A User can create a non-blank post message for a thread", %{session: session} do
        thread = insert(:thread)
        user = insert(:user)

        IO.puts "ZZZZZZZZZZZZZZ"
        IO.inspect session
        IO.puts "ZZZZZZZZZZZZZZ"

        session
        |> visit("/thread/#{thread.id}/post")
        |> take_screenshot
        |> click(link("New post"))
        |> click(button("Submit"))
        |> assert_has(css(".help-block", text: "can't be blank"))
        |> fill_in(text_field("post_message"), with: "Here is my post")
        |> click(button("Submit"))
        |> assert_has(css(".timeline-body", text: "Here is my post"))
    end
  end
end
