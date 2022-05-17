defmodule Pontos.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :points, :integer

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:points])
    |> validate_inclusion(:points, 0..100)
    |> validate_required([:points])
  end

  def points_interval do
    0..100
  end
end
