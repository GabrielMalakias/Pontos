defmodule PontosWeb.PointController do
  use PontosWeb, :controller

  def index(conn, _) do
    json(conn, %{id: "Hello world"})
  end
end
