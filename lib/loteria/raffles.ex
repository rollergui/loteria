defmodule Loteria.Raffles do
  @moduledoc """
  The Raffles context.
  """

  import Ecto.Query, warn: false
  alias Loteria.Repo

  alias Loteria.Users
  alias Loteria.Raffles.Raffle

  @doc """
  Returns the list of raffles.

  ## Examples

      iex> list_raffles()
      [%Raffle{}, ...]

  """
  def list_raffles do
    Repo.all(Raffle)
  end

  @doc """
  Gets a single raffle.

  Raises `Ecto.NoResultsError` if the Raffle does not exist.

  ## Examples

      iex> get_raffle!(123)
      %Raffle{}

      iex> get_raffle!(456)
      ** (Ecto.NoResultsError)

  """
  def get_raffle!(id), do: Repo.get!(Raffle, id)

  @doc """
  Creates a raffle.

  ## Examples

      iex> create_raffle(%{field: value})
      {:ok, %Raffle{}}

      iex> create_raffle(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_raffle(attrs \\ %{}) do
    %Raffle{}
    |> Raffle.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a raffle.

  ## Examples

      iex> update_raffle(raffle, %{field: new_value})
      {:ok, %Raffle{}}

      iex> update_raffle(raffle, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_raffle(%Raffle{} = raffle, attrs) do
    raffle
    |> Raffle.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a raffle.

  ## Examples

      iex> delete_raffle(raffle)
      {:ok, %Raffle{}}

      iex> delete_raffle(raffle)
      {:error, %Ecto.Changeset{}}

  """
  def delete_raffle(%Raffle{} = raffle) do
    Repo.delete(raffle)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking raffle changes.

  ## Examples

      iex> change_raffle(raffle)
      %Ecto.Changeset{data: %Raffle{}}

  """
  def change_raffle(%Raffle{} = raffle, attrs \\ %{}) do
    Raffle.changeset(raffle, attrs)
  end

  def get_result(raffle_id) do
    raffle = Repo.get!(Raffle, raffle_id)
    if ongoing_raffle?(raffle) do
      {:error, :raffle_open}
    else
      user = raffle
      |> get_winner()
      |> Users.get_user!()
      {:ok, user}
    end
  end

  def add_user(raffle_id, user_id) do
    raffle = Repo.get!(Raffle, raffle_id)
    if ongoing_raffle?(raffle) do
      user = Users.get_user!(user_id)
      raffle
      |> Repo.preload(:users)
      |> Raffle.add_user_changeset(user)
      |> Repo.update()
    else
      {:error, :raffle_closed}
    end
  end

  defp ongoing_raffle?(%{winner: winner}) when not is_nil(winner), do: false
  defp ongoing_raffle?(%{draw_date: draw_date}), do: DateTime.diff(draw_date, DateTime.utc_now(), :minute) >= 0

  defp get_winner(%{winner: nil} = raffle) do
    raffle
    |> Repo.preload(:users)
    |> Raffle.set_winner_changeset
    |> Repo.update()
  end

  defp get_winner(%{winner: winner}), do: winner
end
