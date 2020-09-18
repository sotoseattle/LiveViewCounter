# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :turbo_counter,
  ecto_repos: [TurboCounter.Repo]

# Configures the endpoint
config :turbo_counter, TurboCounterWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "nO5HaAUdab8PHjLmfCfsFklrrBrdFE3po+1iFk8AVGE7hEK+0aes6YI9tqEWzeNm",
  render_errors: [view: TurboCounterWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: TurboCounter.PubSub,
  live_view: [signing_salt: "LqZJ//1E"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
