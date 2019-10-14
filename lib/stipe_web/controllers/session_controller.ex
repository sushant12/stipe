defmodule StipeWeb.SessionController do
  use StipeWeb, :controller

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"session" => %{"email" => email, "password" => pass}}) do
    case Stipe.Accounts.authenticate_by_email_and_pass(email, pass) do
      {:ok, user} ->
        conn
        |> StipeWeb.Auth.login(user)
        |> put_flash(:info, "Welcome Back")
        |> redirect(to: Routes.organization_path(conn, :index))

      {:error, _reason} ->
        conn
        |> put_flash(:error, "Invalid username/password combination")
        |> render("new.html")
    end
  end

  def delete(conn, _params) do
    conn
    |> StipeWeb.Auth.logout()
    |> redirect(to: Routes.session_path(conn, :new))
  end
end
