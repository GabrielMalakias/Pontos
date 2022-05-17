defmodule Pontos.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :points, :integer

      timestamps()
    end

    create constraint(:users, :points_must_be_in_range, check: "points >= 0 AND points <= 100")
  end
end
