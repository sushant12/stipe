defmodule StipeWeb.DailyUpdateControllerTest do
  use StipeWeb.ConnCase

  alias Stipe.Standup

  @create_attrs %{remarks: "some remarks", started_on: ~N[2010-04-17 14:00:00], status: 42, task_number: "some task_number", time_spent: "120.5"}
  @update_attrs %{remarks: "some updated remarks", started_on: ~N[2011-05-18 15:01:01], status: 43, task_number: "some updated task_number", time_spent: "456.7"}
  @invalid_attrs %{remarks: nil, started_on: nil, status: nil, task_number: nil, time_spent: nil}

  def fixture(:daily_update) do
    {:ok, daily_update} = Standup.create_daily_update(@create_attrs)
    daily_update
  end

  describe "index" do
    test "lists all daily_updates", %{conn: conn} do
      conn = get(conn, Routes.daily_update_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Daily updates"
    end
  end

  describe "new daily_update" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.daily_update_path(conn, :new))
      assert html_response(conn, 200) =~ "New Daily update"
    end
  end

  describe "create daily_update" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.daily_update_path(conn, :create), daily_update: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.daily_update_path(conn, :show, id)

      conn = get(conn, Routes.daily_update_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Daily update"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.daily_update_path(conn, :create), daily_update: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Daily update"
    end
  end

  describe "edit daily_update" do
    setup [:create_daily_update]

    test "renders form for editing chosen daily_update", %{conn: conn, daily_update: daily_update} do
      conn = get(conn, Routes.daily_update_path(conn, :edit, daily_update))
      assert html_response(conn, 200) =~ "Edit Daily update"
    end
  end

  describe "update daily_update" do
    setup [:create_daily_update]

    test "redirects when data is valid", %{conn: conn, daily_update: daily_update} do
      conn = put(conn, Routes.daily_update_path(conn, :update, daily_update), daily_update: @update_attrs)
      assert redirected_to(conn) == Routes.daily_update_path(conn, :show, daily_update)

      conn = get(conn, Routes.daily_update_path(conn, :show, daily_update))
      assert html_response(conn, 200) =~ "some updated remarks"
    end

    test "renders errors when data is invalid", %{conn: conn, daily_update: daily_update} do
      conn = put(conn, Routes.daily_update_path(conn, :update, daily_update), daily_update: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Daily update"
    end
  end

  describe "delete daily_update" do
    setup [:create_daily_update]

    test "deletes chosen daily_update", %{conn: conn, daily_update: daily_update} do
      conn = delete(conn, Routes.daily_update_path(conn, :delete, daily_update))
      assert redirected_to(conn) == Routes.daily_update_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.daily_update_path(conn, :show, daily_update))
      end
    end
  end

  defp create_daily_update(_) do
    daily_update = fixture(:daily_update)
    {:ok, daily_update: daily_update}
  end
end
