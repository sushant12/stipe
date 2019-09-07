defmodule Stipe.Company.Organization do
  use Ecto.Schema
  import Ecto.Changeset

  schema "organizations" do
    field :name, :string
    has_many :users, Stipe.Accounts.User, on_delete: :delete_all

    timestamps()
  end

  @doc false
  def changeset(organization, attrs) do
    organization
    |> cast(attrs, [:name])
    |> cast_assoc(:users)
    |> validate_required([:name])
  end
end
