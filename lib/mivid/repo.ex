defmodule Mivid.Repo do
  # use Ecto.Repo, otp_app: :mivid
  @moduledoc """
  In memory repository
  """

  def all(Mivid.User) do
    [
      %Mivid.User{id: 1, name: "Jose", username: "josevalim", password: "elixir"},
      %Mivid.User{id: 2, name: "Thao", username: "Hoang", password: "thaohoang"},
      %Mivid.User{id: 3, name: "Chris", username: "chrismccord", password: "phx"}
    ]
  end

  def get(module, id) do
    Enum.find all(module), fn map -> map.id == id end
  end

  def get_by(module, params) do
    Enum.find all(module), fn map ->
      Enum.all?(params, fn {key, val} -> Map.get(map, key) == val end)
    end
  end
end
