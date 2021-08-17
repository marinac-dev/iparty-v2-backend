defmodule IpartyBackendWeb.UserController do
  use IpartyBackendWeb, :controller

  alias IpartyBackend.{Accounts, Guardian, Accounts.User}

  action_fallback IpartyBackendWeb.FallbackController

  @failed_auth "Please provide username and password"
  @failed_regs "Please provide email, username and password"

  # Public

  def show_public(conn, %{"id" => id}) do
    user = Accounts.get_user(id)

    conn |> json(%{username: user.username})
  end

  def sign_up(conn, %{"password" => _, "username" => _, "email" => _} = params) do
    with {:ok, %User{} = user} <- Accounts.create_user(params) do
      {:ok, token, _claims} = Guardian.encode_and_sign(user)

      conn
      |> put_status(:created)
      |> put_resp_header("authorization", "Bearer #{token}")
      |> json(%{token: token})
    end
  end

  def sign_up(conn, _params),
    do: conn |> put_status(400) |> json(%{error: @failed_regs})

  def sign_in(conn, %{"password" => pass, "username" => user}) do
    case Accounts.get_user_by_username_and_password(user, pass) do
      {:ok, %User{} = user} ->
        {:ok, token, _claims} = Guardian.encode_and_sign(user)

        conn
        |> put_resp_header("authorization", "Bearer #{token}")
        |> json(%{token: token})

      {:error, _reason} ->
        conn
        |> put_status(401)
        |> json(%{message: "User not found"})
    end
  end

  def sign_in(conn, _params),
    do: conn |> put_status(401) |> json(%{error: @failed_auth})

  # Private

  def index(conn, _params) do
    users = Accounts.list_users()
    conn |> json(users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user(id)
    conn |> json(user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user(id)

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user(id)

    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
