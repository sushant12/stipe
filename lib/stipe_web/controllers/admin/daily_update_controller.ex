defmodule StipeWeb.Admin.DailyUpdateController do
  use StipeWeb, :controller

  alias Stipe.Accounts
  alias Stipe.Standup

  plug :authenticate

  def index(conn, %{"user_id" => user_id}) do
    %Stipe.Accounts.User{name: name, daily_updates: daily_updates} =
      Accounts.get_user!(user_id)
      |> Stipe.Repo.preload(:daily_updates)

    # daily_updates = Standup.list_daily_updates(%Stipe.Accounts.User{id: user_id})
    render(conn, "index.html", user_name: name, daily_updates: daily_updates)
  end

  defp authenticate(conn, _) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:info, "Please enter your email address to continue.")
      |> redirect(to: Routes.organization_path(conn, :index))
      |> halt()
    end
  end
end
