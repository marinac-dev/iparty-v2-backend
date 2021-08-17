# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :iparty_backend,
  ecto_repos: [IpartyBackend.Repo]

# Configures the endpoint
config :iparty_backend, IpartyBackendWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "y6z52pNsoqAFBEbCYlKlzxQJtYHsMzWi4bynUmZ20II0iQzYlFbTMTu15+AOL4jn",
  render_errors: [view: IpartyBackendWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: IpartyBackend.PubSub,
  live_view: [signing_salt: "/3r8xw8l"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
