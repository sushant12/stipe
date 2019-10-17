# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :stipe,
  ecto_repos: [Stipe.Repo]

# Configures the endpoint
config :stipe, StipeWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "9iBnhdHXBU7xmW+DhBvIsDun/SWVMyTgP8a53Ds7UWkndQMCnRd6Z1u4uFU4k+7e",
  render_errors: [view: StipeWeb.ErrorView, accepts: ~w(html json)],
  live_view: [
    signing_salt: "yCS2vUnINpTZYOMQkArWB77A9Xlgp0nW"
  ],
  pubsub: [name: Stipe.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
