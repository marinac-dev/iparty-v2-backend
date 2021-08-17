defmodule IpartyBackend.Repo do
  use Ecto.Repo,
    otp_app: :iparty_backend,
    adapter: Ecto.Adapters.Postgres
end
