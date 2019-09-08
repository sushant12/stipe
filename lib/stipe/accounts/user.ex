defmodule Stipe.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Stipe.Company.Organization
  alias Stipe.Standup.DailyUpdate

  schema "users" do
    field :admin, :boolean, default: false
    field :email, :string
    field :name, :string
    belongs_to :organization, Organization
    has_many :daily_updates, DailyUpdate, on_delete: :delete_all

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :admin])
    |> validate_required([:name, :email])
  end
end
