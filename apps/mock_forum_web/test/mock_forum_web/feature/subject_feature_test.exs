defmodule MockForum.Web.Feature.SubjectFeatureTest do
  use MockForum.Web.FeatureCase, async: true

  import Wallaby.Query, only: [text_field: 1, link: 1, button: 1]

  test "User can create a new subject", %{session: session} do
    session
    |> visit("/")
    |> click(link("new subject"))
    |> fill_in(text_field("subject_title"), with: "My Title")
    |> click(button("Submit"))
    |> assert_has(link("My Title"))
  end

  test "User can view a subject", %{session: session} do
  end
  
end