defmodule Stipe.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS citext WITH SCHEMA public;"
    create table(:users) do
      add :name, :string
      add :email, :citext, null: false
      add :admin, :boolean, default: false, null: false

      timestamps()
    end
    create unique_index(:users, [:email])
  end
end
