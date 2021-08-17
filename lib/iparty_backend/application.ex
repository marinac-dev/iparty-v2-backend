defmodule IpartyBackend.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      IpartyBackend.Repo,
      # Start the Telemetry supervisor
      IpartyBackendWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: IpartyBackend.PubSub},
      # Start the Endpoint (http/https)
      IpartyBackendWeb.Endpoint
      # Start a worker by calling: IpartyBackend.Worker.start_link(arg)
      # {IpartyBackend.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: IpartyBackend.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    IpartyBackendWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
