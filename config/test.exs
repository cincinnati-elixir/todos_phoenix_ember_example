use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :todo_channels, TodoChannels.Endpoint,
  http: [port: 4001],
  server: true

# Print only warnings and errors during test
config :logger, level: :warn

config :hound, driver: "selenium"

# Configure your database
config :todo_channels, TodoChannels.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "todo_channels_test",
  pool: Ecto.Adapters.SQL.Sandbox
