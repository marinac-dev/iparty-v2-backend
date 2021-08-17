defmodule IpartyBackendWeb.Router do
  use IpartyBackendWeb, :router
  import Plug.BasicAuth
  import Phoenix.LiveDashboard.Router

  pipeline :admin do
    plug :basic_auth, Application.compile_env(:iparty_backend, :admin_dashboard)
  end

  pipeline :auth do
    plug IpartyBackendWeb.Auth.AccessPipeline
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # Api endpoind versioned with /api/v{VERSION_NUMBER}
  scope "/api/v1", IpartyBackendWeb do
    # Public pipe
    pipe_through :api

    scope "/auth" do
      post "/sign-in", UserController, :sign_in
      post "/sign-up", UserController, :sign_up
    end

    scope "/public" do
      get "/users/:id", UserController, :show_public
    end

    # Authenticated pipe
    scope "/private" do
      pipe_through :auth

      resources "/users", UserController, except: [:new, :edit]
    end
  end

  scope "/admin", IpartyBackendWeb do
    pipe_through [:fetch_session, :protect_from_forgery, :admin]
    live_dashboard "/dashboard", metrics: IpartyBackendWeb.Telemetry
  end
end
