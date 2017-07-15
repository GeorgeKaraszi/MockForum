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

alias MockForum.{Repo, Category}

categories = [ %{title: "First Category"}, %{title: "Secound Category"} ]

for category <- categories do
    Repo.insert! %Category{title: category.title}
end
