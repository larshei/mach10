defmodule Mach10Web.PageController do
  use Mach10Web, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
