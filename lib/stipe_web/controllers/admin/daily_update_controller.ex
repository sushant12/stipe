defmodule StipeWeb.Admin.DailyUpdateController do
  use StipeWeb, :controller

  alias Stipe.Accounts
  alias Stipe.Standup

  def index(conn, %{"user_id" => user_id}) do
    daily_updates = Standup.list_daily_updates(%Stipe.Accounts.User{id: user_id})
    # daily_updates = Standup.list_daily_updates(current_user)
    render(conn, "index.html", daily_updates: daily_updates)
  end
end
