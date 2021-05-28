defmodule ExGithub.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      ExGithub.Repo,
      # Start the Telemetry supervisor
      ExGithubWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: ExGithub.PubSub},
      # Start the Endpoint (http/https)
      ExGithubWeb.Endpoint
      # Start a worker by calling: ExGithub.Worker.start_link(arg)
      # {ExGithub.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ExGithub.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ExGithubWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
