defmodule Mivid.WatchController do
  use Mivid.Web, :controller

  alias Mivid.Video

  def show(conn, %{"id" => id}) do
    video = Repo.get!(Video, id)
    render conn, "show.html", video: video
  end
end
