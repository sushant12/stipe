defmodule Stipe.Repo.Migrations.CreateDailyUpdates do
  use Ecto.Migration

  def change do
    create table(:daily_updates) do
      add :task_number, :string
      add :status, :integer
      add :time_spent, :decimal
      add :started_on, :naive_datetime
      add :remarks, :string
      add :user_id, references(:users)
      timestamps()
    end

  end
end
