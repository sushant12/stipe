defmodule Stipe.StandupTest do
  use Stipe.DataCase

  alias Stipe.Standup

  describe "daily_updates" do
    alias Stipe.Standup.DailyUpdate

    @valid_attrs %{remarks: "some remarks", started_on: ~N[2010-04-17 14:00:00], status: 42, task_number: "some task_number", time_spent: "120.5"}
    @update_attrs %{remarks: "some updated remarks", started_on: ~N[2011-05-18 15:01:01], status: 43, task_number: "some updated task_number", time_spent: "456.7"}
    @invalid_attrs %{remarks: nil, started_on: nil, status: nil, task_number: nil, time_spent: nil}

    def daily_update_fixture(attrs \\ %{}) do
      {:ok, daily_update} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Standup.create_daily_update()

      daily_update
    end

    test "list_daily_updates/0 returns all daily_updates" do
      daily_update = daily_update_fixture()
      assert Standup.list_daily_updates() == [daily_update]
    end

    test "get_daily_update!/1 returns the daily_update with given id" do
      daily_update = daily_update_fixture()
      assert Standup.get_daily_update!(daily_update.id) == daily_update
    end

    test "create_daily_update/1 with valid data creates a daily_update" do
      assert {:ok, %DailyUpdate{} = daily_update} = Standup.create_daily_update(@valid_attrs)
      assert daily_update.remarks == "some remarks"
      assert daily_update.started_on == ~N[2010-04-17 14:00:00]
      assert daily_update.status == 42
      assert daily_update.task_number == "some task_number"
      assert daily_update.time_spent == Decimal.new("120.5")
    end

    test "create_daily_update/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Standup.create_daily_update(@invalid_attrs)
    end

    test "update_daily_update/2 with valid data updates the daily_update" do
      daily_update = daily_update_fixture()
      assert {:ok, %DailyUpdate{} = daily_update} = Standup.update_daily_update(daily_update, @update_attrs)
      assert daily_update.remarks == "some updated remarks"
      assert daily_update.started_on == ~N[2011-05-18 15:01:01]
      assert daily_update.status == 43
      assert daily_update.task_number == "some updated task_number"
      assert daily_update.time_spent == Decimal.new("456.7")
    end

    test "update_daily_update/2 with invalid data returns error changeset" do
      daily_update = daily_update_fixture()
      assert {:error, %Ecto.Changeset{}} = Standup.update_daily_update(daily_update, @invalid_attrs)
      assert daily_update == Standup.get_daily_update!(daily_update.id)
    end

    test "delete_daily_update/1 deletes the daily_update" do
      daily_update = daily_update_fixture()
      assert {:ok, %DailyUpdate{}} = Standup.delete_daily_update(daily_update)
      assert_raise Ecto.NoResultsError, fn -> Standup.get_daily_update!(daily_update.id) end
    end

    test "change_daily_update/1 returns a daily_update changeset" do
      daily_update = daily_update_fixture()
      assert %Ecto.Changeset{} = Standup.change_daily_update(daily_update)
    end
  end
end
