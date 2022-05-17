defmodule Pontos.Insert do
  def call(_) do
    Pontos.Repo.insert!(%Pontos.User{points: 0})
  end
end
