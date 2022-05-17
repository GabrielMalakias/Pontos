defmodule PontosWeb.UserControllerTest do
  use PontosWeb.ConnCase
  import Ecto.Query, only: [from: 2]

  setup do
    Enum.each(0..10, fn x ->
      Pontos.Repo.insert!(%Pontos.User{points: x})
    end)

    Pontos.User.Server.reset()

    :ok
  end

  describe "GET /" do
    test "lists two users", %{conn: conn} do
      conn = get(conn, Routes.user_path(conn, :index))

      assert length(json_response(conn, 200)["users"]) == 2
    end

    test "populates only in the second call", %{conn: conn} do
      conn = get(conn, Routes.user_path(conn, :index))
      assert json_response(conn, 200)["timestamp"] == nil

      conn = get(conn, Routes.user_path(conn, :index))
      {:ok, datetime, _} = DateTime.from_iso8601(json_response(conn, 200)["timestamp"])
      assert datetime != nil
    end

    test "updates the points when evaluate is called" do
      old_user = Pontos.Repo.one!(from u in Pontos.User, limit: 1)

      :timer.sleep(300)

      user = Pontos.Repo.get_by!(Pontos.User, id: old_user.id)
      assert user.points != old_user.points
    end
  end
end
