defmodule Mivid.UserController do
  use Mivid.Web, :controller

  def index(conn, _params) do
    users = Repo.all(Mivid.User)
    render conn, "index.html", users: users
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get(Mivid.User, String.to_integer id)
    render conn, "show.html", user: user
  end
end
