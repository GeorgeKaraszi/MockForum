defmodule MockForum.Web.Feature.SubjectFeatureTest do
  @moduledoc false

  use MockForum.Web.FeatureCase, async: true
  import Wallaby.Query, only: [text_field: 1, link: 1, button: 1, css: 2]

   setup %{session: session} do
    user = insert(:user)

    session
    |> visit("/")
    |> set_cookie("user_id", user.id)

    {:ok, session: session, user: user}
  end

  describe "Creating a new category" do
    test "User can create a new category and view it", %{session: session} do
      session
      |> visit("/")
      |> click(link("new category"))
      |> fill_in(text_field("category_title"), with: "My Title")
      |> click(button("Submit"))
      |> assert_has(link("My Title"))
    end

    test "A category title cannot be blank", %{session: session} do
       insert(:category)

      session
      |> visit("/")
      |> click(link("new category"))
      |> click(button("Submit"))
      |> assert_has(css(".help-block", text: "can't be blank"))
    end
  end

  describe "Viewing a new category" do
    test "A category can be clicked on linking to topics", %{session: session} do
      category = insert(:category)
      session
      |> visit("/")
      |> click(link(category.title))
      |> assert_has(link("New Thread"))
    end
  end
end
