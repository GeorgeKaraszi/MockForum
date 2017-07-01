defmodule MockForum.Web.Feature.ThreadFeatureTest do
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

  describe "Creating a new thread" do
    test "A thread name cannot be blank", %{session: session} do
        subject = insert(:subject)

        session
        |> visit("/subject/#{subject.id}")
        |> click(link("New Thread"))
        |> fill_in(text_field("thread_posts_0_message"), with: "Here is my thread body")
        |> click(button("Submit"))
        |> assert_has(css(".help-block", text: "can't be blank"))
        |> fill_in(text_field("thread_title"), with: "Here is my thread name")
        |> click(button("Submit"))
        |> assert_has(link("Here is my thread name"))
    end

    test "A thread message cannot be blank", %{session: session} do
        subject = insert(:subject)
        session
        |> visit("/subject/#{subject.id}")
        |> click(link("New Thread"))
        |> fill_in(text_field("thread_title"), with: "Here is my thread title")
        |> click(button("Submit"))
        |> assert_has(css(".help-block", text: "can't be blank"))
        |> fill_in(text_field("thread_posts_0_message"), with: "Here is my thread body")
        |> click(button("Submit"))
        |> assert_has(link("Here is my thread title"))
    end

    test "Creating a new thread creates a message", %{session: session} do
        subject = insert(:subject)
        session
        |> visit("/subject/#{subject.id}")
        |> click(link("New Thread"))
        |> fill_in(text_field("thread_title"), with: "Here is my thread title")
        |> fill_in(text_field("thread_posts_0_message"), with: "Here is my thread body")
        |> click(button("Submit"))
        |> click(link("Here is my thread title"))
        |> assert_has(css(".timeline-body", text: "Here is my thread body"))
    end
  end

  describe "Viewing a new thread" do
    test "A subject can be clicked on linking to topics", %{session: session} do
      thread = insert(:thread)
      session
      |> visit("/subject/#{thread.subject_id}")
      |> click(link(thread.title))
      |> assert_has(link("New post"))
    end
  end
end
