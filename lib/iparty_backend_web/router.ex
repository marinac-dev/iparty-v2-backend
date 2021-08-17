defmodule IpartyBackendWeb.Router do
  use IpartyBackendWeb, :router
  import Plug.BasicAuth
  import Phoenix.LiveDashboard.Router

  pipeline :admin do
    plug :basic_auth, Application.compile_env(:iparty_backend, :admin_dashboard)
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", IpartyBackendWeb do
    pipe_through :api
  end

  scope "/admin", IpartyBackendWeb do
    pipe_through [:fetch_session, :protect_from_forgery, :admin]
    live_dashboard "/dashboard", metrics: IpartyBackendWeb.Telemetry
  end
end
