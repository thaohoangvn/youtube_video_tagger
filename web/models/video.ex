defmodule Mivid.Video do
  use Mivid.Web, :model

  @required_fields [:title, :url, :description] 
  @optional_fields []

  schema "videos" do
    field :url, :string
    field :title, :string
    field :description, :string
    belongs_to :user, Mivid.User

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields, @optional_fields)
    |> validate_required(@required_fields)
  end
end
