defmodule Mivid.PageControllerTest do
  use Mivid.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "My Videos Rock!"
  end
end
