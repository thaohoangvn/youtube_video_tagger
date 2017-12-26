defmodule Mivid.UserTest do
  use Mivid.ModelCase, async: true
  alias Mivid.User

  @valid_attrs %{name: "A User", username: "eva", password: "secret"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "changeset does not accept long username" do
    attrs = Map.put(@valid_attrs, :username, String.duplicate("a", 30))
    assert [username: "should be at most 20 character(s)"] == errors_on(%User{}, attrs)
  end
end
