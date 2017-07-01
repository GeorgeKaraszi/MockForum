defmodule MockForum.Web.Feature.SubjectFeatureTest do
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

  describe "Creating a new subject" do
    test "User can create a new subject and view it", %{session: session} do
      session
      |> visit("/")
      |> click(link("new subject"))
      |> fill_in(text_field("subject_title"), with: "My Title")
      |> click(button("Submit"))
      |> assert_has(link("My Title"))
    end

    test "A subject name cannot be blank", %{session: session} do
      session
      |> visit("/")
      |> click(link("new subject"))
      |> click(button("Submit"))
      |> assert_has(css(".help-block", text: "can't be blank"))
    end
  end

  describe "Viewing a new subject" do
    test "A subject can be clicked on linking to topics", %{session: session} do
      subject = insert(:subject)
      session
      |> visit("/")
      |> click(link(subject.title))
      |> assert_has(link("New Thread"))
    end
  end
end
