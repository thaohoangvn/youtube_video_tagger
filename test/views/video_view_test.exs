defmodule Mivid.VideoViewTest do
  use Mivid.ConnCase, async: true

  import Phoenix.View

  test "renders index.html", %{conn: conn} do
    videos = [
      %Mivid.Video{id: "1", title: "Dogs"},
      %Mivid.Video{id: "2", title: "Cats"}
    ]
    content = render_to_string(Mivid.VideoView, "index.html", conn: conn, videos: videos)
    assert String.contains?(content, "Listing videos")
    for video <- videos do
      assert String.contains?(content, video.title)
    end
  end

  test "renders new.html", %{conn: conn} do
    changeset = Mivid.Video.changeset(%Mivid.Video{})
    categories = [{"cats", 123}]
    content = render_to_string(Mivid.VideoView, "new.html", conn: conn, changeset: changeset, categories: categories)
    assert String.contains?(content, "New video")
  end
end
