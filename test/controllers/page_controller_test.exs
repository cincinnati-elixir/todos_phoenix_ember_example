defmodule TodoChannels.PageControllerTest do
  use TodoChannels.ConnCase

  test "GET /" do
    conn = get conn(), "/"
    assert html_response(conn, 200) =~ "Welcome to Phoenix!"
  end
end
