defmodule Stipe.Home do
  @moduledoc """
  The Home context.
  """

  import Ecto.Query, warn: false
  alias Stipe.Repo

  alias Stipe.Accounts.User

  def find_user_with_email(email) do
    user = Repo.get_by(User, email: email)

    case user do
      %Stipe.Accounts.User{email: _email} ->
        {:ok, user}

      nil ->
        {:error, "Email not found"}
    end
  end
end
