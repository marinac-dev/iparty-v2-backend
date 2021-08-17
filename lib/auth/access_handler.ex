defmodule IpartyBackendWeb.Auth.AccessPipeline do
  use Guardian.Plug.Pipeline, otp_app: :iparty_backend

  plug Guardian.Plug.Pipeline, module: IpartyBackend.Guardian, error_handler: IpartyBackendWeb.Auth.ErrorHandler

  # If there is a session token, validate it
  plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
  # If there is an authorization header, validate it
  plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
  # Check if legit token is provided and verify it
  plug Guardian.Plug.EnsureAuthenticated
  # Load the user if either of the verifications worked
  plug Guardian.Plug.LoadResource
end
