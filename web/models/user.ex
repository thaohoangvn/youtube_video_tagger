defmodule Mivid.User do
  use Mivid.Web, :model

  schema "users" do
    field :name, :string
    field :username, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end

  def changeset(model, params \\ %{}) do
    model
    |> cast(params, ~w(name username), [])
  end

  def changeset_create(model, params) do
    model
    |> cast(params, ~w(name username password), [])
    |> validate_required([:name, :username, :password])
    |> unique_constraint(:username)
    |> validate_length(:username, min: 1, max: 20)
  end
end
