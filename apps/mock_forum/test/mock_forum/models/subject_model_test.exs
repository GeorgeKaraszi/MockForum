defmodule MockForum.Model.SubjectTest do
    @moduledoc false

  use MockForum.DataCase
  alias MockForum.Subject

  setup do
    subject = insert(:subject)
    threads = 5 |> insert_list(:thread, subject: subject) |> with_posts
    %{subject: subject, threads: threads}
  end

  test "order_by_latest_threads", %{subject: subject, threads: threads} do
    ordered_subject =
      subject
      |> Subject.order_by_latest_threads
      |> Repo.one!

    %{id: last_thread_id}  = threads |> List.last
    %{id: first_thread_id} = ordered_subject.threads |> List.first
    assert last_thread_id == first_thread_id
  end
end
