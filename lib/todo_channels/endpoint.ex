defmodule TodoChannels.Endpoint do
  use Phoenix.Endpoint, otp_app: :todo_channels

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phoenix.digest
  # when deploying your static files in production.
  plug Plug.Static,
    at: "/", from: :todo_channels, gzip: false,
    only: ~w(css images js favicon.ico robots.txt assets index.html)

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
  end

  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  plug Plug.Session,
    store: :cookie,
    key: "_todo_channels_key",
    signing_salt: "BAAiX5QG"

  plug :router, TodoChannels.Router
end

