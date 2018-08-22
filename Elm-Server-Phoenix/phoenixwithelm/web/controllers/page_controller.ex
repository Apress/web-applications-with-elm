defmodule Phoenixwithelm.PageController do
  use Phoenixwithelm.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
