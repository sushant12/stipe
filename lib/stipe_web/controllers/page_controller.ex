defmodule StipeWeb.PageController do
  use StipeWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
