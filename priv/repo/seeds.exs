# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Pontos.Repo.insert!(%Pontos.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
Task.async_stream(0..1_000_000, Pontos.Insert, :call, [], max_concurrency: 30) |> Stream.run()
