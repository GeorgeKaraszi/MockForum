defmodule MockForum.Model.SubjectTest do
    @moduledoc false

  use MockForum.DataCase
  alias MockForum.Category

  setup do
    category = insert(:category)
    threads  = 5 |> insert_list(:thread, category: category) |> with_posts
    %{category: category, threads: threads}
  end

  test ".order_by_latest_threads", %{category: category, threads: threads} do
    ordered_category = category |> Category.order_by_latest_threads |> Repo.one!

    [%{id: newest_id}, %{id: next_newest_id}] = ordered_category.threads |> Enum.take(2)

    # Enum take(-2) will reverse the order IE: [1,2] returns [2,1]
    [%{id: local_next_newest_id}, %{id: local_newest_id}] = threads |> Enum.take(-2)

    assert newest_id == local_newest_id
    assert next_newest_id == local_next_newest_id
  end

  test ".latest_unqiue_threads", %{threads: threads} do
    [category]     = Category.latest_unqiue_threads |> Repo.all
    [first_thread] = category.threads
    latest_thread  = List.first(threads)

    assert latest_thread.id == first_thread.id
  end

end
