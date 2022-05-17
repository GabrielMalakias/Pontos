defmodule Pontos.User.EvaluateTest do
  use ExUnit.Case, async: true
  import Ecto.Query, only: [from: 2]

  setup do
    Ecto.Adapters.SQL.Sandbox.checkout(Pontos.Repo)

    Enum.each(0..10, fn x ->
      Pontos.Repo.insert!(%Pontos.User{points: x})
    end)

    :ok
  end

  describe "call" do
    test "updates the user setting assigning a random number of points" do
      user = Pontos.Repo.one!(from u in Pontos.User, limit: 1)
      assert user.points == 0

      Pontos.User.Evaluate.call()

      user = Pontos.Repo.get_by!(Pontos.User, id: user.id)
      assert user.points != 0
    end
  end
end
