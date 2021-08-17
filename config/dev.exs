use Mix.Config

# Configure your database
config :iparty_backend, IpartyBackend.Repo,
  username: "postgres",
  password: "postgres",
  database: "iparty_backend_dev",
  hostname: "localhost",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with webpack to recompile .js and .css sources.
config :iparty_backend, IpartyBackendWeb.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: []

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Initialize plugs at runtime for faster development compilation
config :phoenix, :plug_init_mode, :runtime

# Admin panel | dev config
config :iparty_backend,
  admin_dashboard: [
    username: "admin",
    password: "admin",
    realm: "Do you even admin bro?"
  ]

# Config Guardian | dev
config :iparty_backend, IpartyBackend.Guardian,
  issuer: "iparty_backend",
  secret_key: "kulhtaCiq6CySp0gWzoj3MKhW5Bv0/qE"
