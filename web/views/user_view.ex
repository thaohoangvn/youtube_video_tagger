defmodule Mivid.UserView do
  use Mivid.Web, :view

  def first_name(%{name: name}) do
    IO.inspect "name: #{name}"
    name
    |> String.split(" ")
    |> Enum.at(0)
  end

  def first_name(params) do
    IO.inspect params
  end
end
