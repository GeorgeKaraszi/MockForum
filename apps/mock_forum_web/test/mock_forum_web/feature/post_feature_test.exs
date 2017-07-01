defmodule MockForum.Web.Feature.PostFeatureTest do
  use MockForum.Web.FeatureCase, async: true

  import MockForum.Web.Factory
  import Wallaby.Query, only: [text_field: 1, link: 1, button: 1, css: 2]

 setup %{session: session} do
    user = insert(:user)

    session
    |> visit("/")
    |> set_cookie("user_id", user.id)

    {:ok, session: session, user: user}
  end

  describe "Creating a new post" do
    test "A User can create a non-blank post message for a thread", %{session: session} do
        thread = insert(:thread)

        session
        |> visit("/thread/#{thread.id}/post")
        |> click(link("New post"))
        |> click(button("Submit"))
        |> assert_has(css(".help-block", text: "can't be blank"))
        |> fill_in(text_field("post_message"), with: "Here is my post")
        |> click(button("Submit"))
        |> assert_has(css(".timeline-body", text: "Here is my post"))
    end
  end
end
