alias Mivid.{Repo, Category}

for category <- ~w(Action Drama Romance Comedy Sci-fi Technology) do
  Repo.get_by(Category, name: category) || Repo.insert!(%Category{name: category})
end
