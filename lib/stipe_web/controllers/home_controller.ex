defmodule StipeWeb.HomeController do
  use StipeWeb, :controller

  alias Stipe.Home

  def index(conn, _params) do
    IO.inspect(conn)
    render(conn, "index.html")
  end

  def verify_email(conn, %{"email" => email}) do
    case Home.find_user_with_email(email) do
      {:ok, user} ->
        conn
        |> put_session(:user, user)
        |> redirect(to: Routes.daily_update_path(conn, :index))

      {:error, message} ->
        conn
        |> put_flash(:error, message)
        |> redirect(to: Routes.home_path(conn, :index))
    end
  end
end
