# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     MockForum.Repo.insert!(%MockForum.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias MockForum.{Repo, Category, Subject}

categories = [
    %{title: "Cat 1", subjects: [
        %{title: "First Subject"}, %{title: "Secound Subject"}
    ]},
    %{title: "Cat 2", subjects: [
        %{title: "Last Subject"}
    ]}]

for category <- categories do
    category_inserted = Repo.insert! %Category{title: category.title}
    for subject <- category.subjects do
        Repo.insert! %Subject{title: subject.title, category_id: category_inserted.id}
    end
end
