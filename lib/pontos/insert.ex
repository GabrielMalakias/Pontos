defmodule Pontos.Insert do
  def call(_, record) do
    Pontos.Repo.insert!(record)
  end
end
