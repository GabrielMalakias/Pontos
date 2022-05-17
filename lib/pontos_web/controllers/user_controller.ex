defmodule PontosWeb.UserController do
  use PontosWeb, :controller

  def index(conn, _) do
    json(conn, serialize(Pontos.User.Server.fetch()))
  end

  defp serialize([timestamp, users]) do
    %{users: users, timestamp: timestamp}
  end
end
