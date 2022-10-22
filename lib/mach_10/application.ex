defmodule Mach10.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Mach10.Repo,
      # Start the Telemetry supervisor
      Mach10Web.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Mach10.PubSub},
      # Start the Endpoint (http/https)
      Mach10Web.Endpoint
      # Start a worker by calling: Mach10.Worker.start_link(arg)
      # {Mach10.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Mach10.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    Mach10Web.Endpoint.config_change(changed, removed)
    :ok
  end
end
