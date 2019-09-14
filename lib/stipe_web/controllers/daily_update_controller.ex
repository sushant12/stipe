defmodule StipeWeb.DailyUpdateController do
  use StipeWeb, :controller

  alias Stipe.Standup
  alias Stipe.Standup.DailyUpdate

  plug :valid_user?

  def index(conn, _params, current_user) do
    daily_updates = Standup.list_daily_updates(current_user)
    render(conn, "index.html", daily_updates: daily_updates)
  end

  def new(conn, _params, current_user) do
    changeset = Standup.change_daily_update(%DailyUpdate{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"daily_update" => daily_update_params}, current_user) do
    case Standup.create_daily_update(current_user, daily_update_params) do
      {:ok, daily_update} ->
        conn
        |> put_flash(:info, "Daily update created successfully.")
        |> redirect(to: Routes.daily_update_path(conn, :show, daily_update))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}, current_user) do
    daily_update = Standup.get_daily_update!(current_user, id)
    IO.inspect(daily_update)
    render(conn, "show.html", daily_update: daily_update)
  end

  def edit(conn, %{"id" => id}, current_user) do
    daily_update = Standup.get_daily_update!(current_user, id)
    changeset = Standup.change_daily_update(daily_update)
    render(conn, "edit.html", daily_update: daily_update, changeset: changeset)
  end

  def update(conn, %{"id" => id, "daily_update" => daily_update_params}, current_user) do
    daily_update = Standup.get_daily_update!(current_user, id)

    case Standup.update_daily_update(daily_update, daily_update_params) do
      {:ok, daily_update} ->
        conn
        |> put_flash(:info, "Daily update updated successfully.")
        |> redirect(to: Routes.daily_update_path(conn, :show, daily_update))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", daily_update: daily_update, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}, current_user) do
    daily_update = Standup.get_daily_update!(current_user, id)
    {:ok, _daily_update} = Standup.delete_daily_update(daily_update)

    conn
    |> put_flash(:info, "Daily update deleted successfully.")
    |> redirect(to: Routes.daily_update_path(conn, :index))
  end

  def action(conn, _) do
    args = [conn, conn.params, get_session(conn, :user)]
    apply(__MODULE__, action_name(conn), args)
  end

  defp valid_user?(conn, _opts) do
    user = get_session(conn, :user)

    case user do
      %Stipe.Accounts.User{} ->
        conn

      nil ->
        conn
        |> put_flash(:info, "Please enter your email address to continue.")
        |> redirect(to: Routes.home_path(conn, :index))
    end

    conn
  end
end
