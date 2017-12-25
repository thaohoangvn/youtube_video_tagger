defmodule Mivid.TestHelpers do
  alias Mivid.Repo

  def insert_user(attrs \\ %{}) do
    changes = Map.merge(%{
      name: "Some User",
      username: "user#{Base.encode16(:crypto.strong_rand_bytes(8))}",
      password: "supersecret"
    }, attrs)

    %Mivid.User{}
    |> Mivid.User.registration_changeset(changes)
    |> Repo.insert!()
  end

  def insert_video(user, attrs \\ %{}) do
    user
    |> Ecto.build_assoc(:videos, attrs)
    |> Repo.insert!()
  end
end