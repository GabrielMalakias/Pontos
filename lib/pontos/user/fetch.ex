defmodule Pontos.User.Fetch do
  import Ecto.Query, only: [from: 2]

  @limit 2

  def call(bottom_limit) do
    bottom_limit
    |> query
    |> Pontos.Repo.all()
  end

  defp query(points) do
    from(u in Pontos.User, select: %{id: u.id, points: u.points}, where: u.points > ^points, limit: ^@limit)
  end
end
