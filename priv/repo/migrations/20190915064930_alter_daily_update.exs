defmodule Stipe.Repo.Migrations.AlterDailyUpdate do
  use Ecto.Migration

  def up do
    execute("CREATE TYPE daily_update_status AS ENUM('In Progress', 'In Testing', 'Done');")
    execute("ALTER TABLE daily_updates ALTER COLUMN status DROP DEFAULT;")
    execute("
      ALTER TABLE daily_updates 
              ALTER COLUMN status TYPE daily_update_status 
                USING 
                  CASE status 
                    WHEN NULL then 'In Progress'
                    WHEN 0 then 'In Progress'
                  end :: daily_update_status;
    ")
    execute("
      ALTER TABLE daily_updates
        ALTER COLUMN status SET DEFAULT 'In Progress';  
      ")
  end

  def down do
    execute("ALTER TABLE daily_updates ALTER COLUMN status DROP DEFAULT;")
    execute("
        ALTER TABLE daily_updates
          ALTER COLUMN status TYPE INT 
            USING 
              CASE status
                WHEN NULL then 0
                WHEN 'In Progress' then 0
                WHEN 'In Testing' then 1
                WHEN 'Done' then 2
              end :: integer;
      ")
    execute("
        ALTER TABLE daily_updates
          ALTER COLUMN status SET DEFAULT 0;
      ")
    execute("DROP TYPE IF EXISTS daily_update_status;")
  end
end
