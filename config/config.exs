# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :mivid,
  ecto_repos: [Mivid.Repo]

# Configures the endpoint
config :mivid, Mivid.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "/HECz3sOLBF6c+Z7WRG0kXKy/Cax5rgZUDzCRdbW1+ow73vrttitKRbWcMTM3OLE",
  render_errors: [view: Mivid.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Mivid.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
