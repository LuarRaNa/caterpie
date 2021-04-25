# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :caterpie,
  ecto_repos: [Caterpie.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :caterpie, CaterpieWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "S6FtNB9B3oO8N0b77WGyfGJkI5plI81lxeAfzku0OocyZZsFHOD1D1hUwUR49WtO",
  render_errors: [view: CaterpieWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Caterpie.PubSub,
  live_view: [signing_salt: "/CUMRgy4"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
