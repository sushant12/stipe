defmodule Stipe.Standup do
  @moduledoc """
  The Standup context.
  """

  import Ecto.Query, warn: false
  alias Stipe.Repo

  alias Stipe.Standup.DailyUpdate

  @doc """
  Returns the list of daily_updates.

  ## Examples

      iex> list_daily_updates()
      [%DailyUpdate{}, ...]

  """
  def list_daily_updates do
    Repo.all(DailyUpdate)
  end

  @doc """
  Gets a single daily_update.

  Raises `Ecto.NoResultsError` if the Daily update does not exist.

  ## Examples

      iex> get_daily_update!(123)
      %DailyUpdate{}

      iex> get_daily_update!(456)
      ** (Ecto.NoResultsError)

  """
  def get_daily_update!(id), do: Repo.get!(DailyUpdate, id)

  @doc """
  Creates a daily_update.

  ## Examples

      iex> create_daily_update(%{field: value})
      {:ok, %DailyUpdate{}}

      iex> create_daily_update(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_daily_update(attrs \\ %{}) do
    %DailyUpdate{}
    |> DailyUpdate.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a daily_update.

  ## Examples

      iex> update_daily_update(daily_update, %{field: new_value})
      {:ok, %DailyUpdate{}}

      iex> update_daily_update(daily_update, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_daily_update(%DailyUpdate{} = daily_update, attrs) do
    daily_update
    |> DailyUpdate.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a DailyUpdate.

  ## Examples

      iex> delete_daily_update(daily_update)
      {:ok, %DailyUpdate{}}

      iex> delete_daily_update(daily_update)
      {:error, %Ecto.Changeset{}}

  """
  def delete_daily_update(%DailyUpdate{} = daily_update) do
    Repo.delete(daily_update)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking daily_update changes.

  ## Examples

      iex> change_daily_update(daily_update)
      %Ecto.Changeset{source: %DailyUpdate{}}

  """
  def change_daily_update(%DailyUpdate{} = daily_update) do
    DailyUpdate.changeset(daily_update, %{})
  end
end
