defmodule Stipe.Repo.Migrations.AddCategoryToUser do
  use Ecto.Migration

  def up do
    execute("CREATE TYPE user_category AS ENUM('Employee', 'Manager', 'Lead', 'HR', 'Admin');")
    execute("ALTER TABLE users ADD COLUMN category user_category;")
    execute("
      ALTER TABLE users
        ALTER COLUMN category SET DEFAULT 'Employee';  
      ")
  end

  def down do
    execute("ALTER TABLE users DROP COLUMN category;")
    execute("DROP TYPE IF EXISTS user_category;")
  end
end
