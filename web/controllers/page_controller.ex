defmodule TodoChannels.PageController do
  use TodoChannels.Web, :controller

  plug :action

  def index(conn, _params) do
    render conn, "index.html"
  end
end
