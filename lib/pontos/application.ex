defmodule Pontos.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Pontos.Repo,
      # Start the Telemetry supervisor
      PontosWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Pontos.PubSub},
      # Start the Endpoint (http/https)
      PontosWeb.Endpoint,
      # Start a worker by calling: Pontos.Worker.start_link(arg)
      # {Pontos.Worker, arg}
      #
      # Starts the User Server
      Pontos.User.Server
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Pontos.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PontosWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
