defmodule Pontos.Repo do
  use Ecto.Repo,
    otp_app: :pontos,
    adapter: Ecto.Adapters.Postgres
end
