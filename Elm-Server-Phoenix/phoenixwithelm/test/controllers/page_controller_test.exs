defmodule Phoenixwithelm.PageControllerTest do
  use Phoenixwithelm.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Welcome to Phoenix!"
  end
end
