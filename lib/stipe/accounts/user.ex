defmodule Stipe.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Stipe.Company.Organization
  alias Stipe.Standup.DailyUpdate

  schema "users" do
    field :admin, :boolean, default: false
    field :email, :string
    field :name, :string
    field :category, :string
    field :password, :string, virtual: true
    field :password_hash, :string
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

  def registration_changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :password])
    |> validate_required([:email, :password])
    |> put_pass_hash()
  end

  defp put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Pbkdf2.hash_pwd_salt(pass))

      _ ->
        changeset
    end
  end
end
