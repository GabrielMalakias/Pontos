defmodule Pontos.User.Evaluate do
  import Ecto.Query

  def call do
    Pontos.User
    |> update(set: [points: fragment("FLOOR(RANDOM() * 101)"), updated_at: ^DateTime.utc_now()])
    |> Pontos.Repo.update_all([])
  end
end
