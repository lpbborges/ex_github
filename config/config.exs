# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :ex_github,
  ecto_repos: [ExGithub.Repo]

config :ex_github, ExGithub.Repo, migration_primary_key: [type: :binary_id]

config :ex_github, ExGithubWeb.Auth.Guardian,
  issuer: "ex_github",
  secret_key: "exqLirSYsSGdXh14tT+LpLQ8lSZ0fmEzDj9hWtPk1W6VE3KlE+112uuZWdLoyngJ"

config :ex_github, ExGithubWeb.Auth.Pipeline,
  module: ExGithubWeb.Auth.Guardian,
  error_handler: ExGithubWeb.Auth.ErrorHandler

# Configures the endpoint
config :ex_github, ExGithubWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "pLmAgqolnz3ANc+Igi1CQn/ufVUwaST6MtgasE66TDR3oPAa8GWnb18ntMIWQAb3",
  render_errors: [view: ExGithubWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: ExGithub.PubSub,
  live_view: [signing_salt: "aewkj2JY"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
