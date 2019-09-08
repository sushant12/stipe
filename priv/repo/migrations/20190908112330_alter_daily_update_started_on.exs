defmodule Stipe.Repo.Migrations.AlterDailyUpdateStartedOn do
  use Ecto.Migration

  def change do
    alter table("daily_updates") do
      modify :started_on, :date, from: :datetime
    end
  end
end
