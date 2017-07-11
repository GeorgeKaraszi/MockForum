defmodule MockForum.Model.SubjectTest do
    @moduledoc false

  use MockForum.DataCase
  alias MockForum.Subject

  setup do
    subject = insert(:subject)
    threads = 5 |> insert_list(:thread, subject: subject) |> with_posts
    %{subject: subject, threads: threads}
  end

  test ".order_by_latest_threads", %{subject: subject, threads: threads} do
    ordered_subject = subject |> Subject.order_by_latest_threads |> Repo.one!

    [%{id: newest_id}, %{id: next_newest_id}] = ordered_subject.threads |> Enum.take(2)

    # Enum take(-2) will reverse the order IE: [1,2] returns [2,1]
    [%{id: local_next_newest_id}, %{id: local_newest_id}] = threads |> Enum.take(-2)

    assert newest_id == local_newest_id
    assert next_newest_id == local_next_newest_id
  end

  test ".latest_unqiue_threads", %{threads: threads} do
    [subject]      = Subject.latest_unqiue_threads |> Repo.all
    [first_thread] = subject.threads
    latest_thread  = List.first(threads)

    assert latest_thread.id == first_thread.id
  end

end
