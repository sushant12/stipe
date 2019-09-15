defmodule Stipe.Standup.DailyUpdate do
  use Ecto.Schema
  import Ecto.Changeset
  alias Stipe.Accounts.User

  schema "daily_updates" do
    field :remarks, :string
    field :started_on, :date
    field :status, :string
    field :task_number, :string
    field :time_spent, :decimal
    belongs_to :user, User
    timestamps()
  end

  def statuses do
    ["In Progress": "In Progress", "In Testing": "In Testing", Done: "Done"]
  end

  @doc false
  def changeset(daily_update, attrs) do
    daily_update
    |> cast(attrs, [:task_number, :status, :time_spent, :started_on, :remarks])
    |> cast_assoc(:user)
    |> assoc_constraint(:user)
    |> validate_required([:task_number, :time_spent, :started_on, :remarks])
  end
end
