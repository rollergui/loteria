defmodule Loteria.Raffles.RafflesUsers do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  schema "raffles_users" do
    belongs_to :user, Loteria.Users.User
    belongs_to :raffle, Loteria.Raffles.Raffle

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(raffles_users, attrs) do
    raffles_users
    |> cast(attrs, [:raffle_id, :participant_id])
    |> validate_required([:raffle_id, :participant_id])
  end
end
