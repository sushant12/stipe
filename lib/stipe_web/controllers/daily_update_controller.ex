defmodule StipeWeb.DailyUpdateController do
  use StipeWeb, :controller

  alias Stipe.Standup
  alias Stipe.Standup.DailyUpdate

  def index(conn, _params) do
    daily_updates = Standup.list_daily_updates()
    render(conn, "index.html", daily_updates: daily_updates)
  end

  def new(conn, _params) do
    changeset = Standup.change_daily_update(%DailyUpdate{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"daily_update" => daily_update_params}) do
    case Standup.create_daily_update(daily_update_params) do
      {:ok, daily_update} ->
        conn
        |> put_flash(:info, "Daily update created successfully.")
        |> redirect(to: Routes.daily_update_path(conn, :show, daily_update))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    daily_update = Standup.get_daily_update!(id)
    render(conn, "show.html", daily_update: daily_update)
  end

  def edit(conn, %{"id" => id}) do
    daily_update = Standup.get_daily_update!(id)
    changeset = Standup.change_daily_update(daily_update)
    render(conn, "edit.html", daily_update: daily_update, changeset: changeset)
  end

  def update(conn, %{"id" => id, "daily_update" => daily_update_params}) do
    daily_update = Standup.get_daily_update!(id)

    case Standup.update_daily_update(daily_update, daily_update_params) do
      {:ok, daily_update} ->
        conn
        |> put_flash(:info, "Daily update updated successfully.")
        |> redirect(to: Routes.daily_update_path(conn, :show, daily_update))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", daily_update: daily_update, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    daily_update = Standup.get_daily_update!(id)
    {:ok, _daily_update} = Standup.delete_daily_update(daily_update)

    conn
    |> put_flash(:info, "Daily update deleted successfully.")
    |> redirect(to: Routes.daily_update_path(conn, :index))
  end
end
