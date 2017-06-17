defmodule MockForum.Web.Feature.ThreadFeatureTest do
    import MockForum.Web.Router.Helpers

  use MockForum.Web.FeatureCase, async: true

  import MockForum.Web.Factory
  import Wallaby.Query, only: [text_field: 1, link: 1, button: 1, css: 2]

  describe "Creating a new thread" do
    test "User can create a new thread and view it", %{session: session} do
        subject = insert(:subject)
        session
        |> visit("/subject/#{subject.id}")
        |> click(link("New Thread"))
        |> fill_in(text_field("thread_title"), with: "Here is my thread name")
        |> click(button("Submit"))
        |> assert_has(link("Here is my thread name"))
    end

    test "A thread name cannot be blank", %{session: session} do
        subject = insert(:subject)
        session
        |> visit("/subject/#{subject.id}")
        |> click(link("New Thread"))
        |> click(button("Submit"))
        |> assert_has(css(".help-block", text: "can't be blank"))
    end
  end

  describe "Viewing a new thread" do
    test "A subject can be clicked on linking to topics", %{session: session} do
      thread = insert(:thread)
      session
      |> visit("/subject/#{thread.subject_id}")
      |> click(link(thread.title))
      |> assert_has(link("Delete Thread"))
    end
  end
end