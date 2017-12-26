defmodule Mivid.CategoryRepoTest do
  use Mivid.ModelCase

  alias Mivid.Category

  test "alphabetical/1 orders by name" do
    Repo.insert!(%Category{name: "c"})
    Repo.insert!(%Category{name: "b"})
    Repo.insert!(%Category{name: "a"})

    query = Category |> Category.alphabetical()
    query = from c in query, select: c.name
    assert Repo.all(query) == ~w(a b c)
  end
end
