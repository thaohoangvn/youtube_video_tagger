defmodule Mivid.UserRepoTest do
  use Mivid.ModelCase
  alias Mivid.User

  @valid_attrs %{name: "A User", username: "eva", password: "secret"}

  test "converts unique_constraint on username to error" do
    insert_user(%{username: "eric"})
    attrs = Map.put(@valid_attrs, :username, "eric")
    changeset = User.registration_changeset(%User{}, attrs)

    assert {:error, changeset} = Repo.insert(changeset)
    assert [username: {"has already been taken", []}] == changeset.errors
  end
end
