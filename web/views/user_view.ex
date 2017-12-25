defmodule Mivid.UserView do
  use Mivid.Web, :view

  def first_name(%{name: name}) do
    name
    |> String.split(" ")
    |> Enum.at(0)
  end
end
