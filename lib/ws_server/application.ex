defmodule WsServer.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      WsServerWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:ws_server, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: WsServer.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: WsServer.Finch},
      # Start a worker by calling: WsServer.Worker.start_link(arg)
      # {WsServer.Worker, arg},
      # Start to serve requests, typically the last entry
      WsServerWeb.Endpoint,
      {KafkaClient, []}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: WsServer.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    WsServerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
