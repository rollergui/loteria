defmodule Loteria.Raffles.Raffle do
  use Ecto.Schema
  import Ecto.Changeset

  schema "raffles" do
    field :draw_date, :utc_datetime
    field :name, :string
    field :winner, :integer, references: Loteria.Users.User, default: nil
    many_to_many :users, Loteria.Users.User, join_through: Loteria.Raffles.RafflesUsers

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(raffle, attrs) do
    raffle
    |> cast(attrs, [:name, :draw_date])
    |> validate_required([:name, :draw_date])
  end

  def add_user_changeset(raffle, user) do
    raffle
    |> change()
    |> put_assoc(:users, [user|raffle.users])
  end

  def set_winner_changeset(raffle) do
    raffle
    |> change()
    |> put_change(:winner, Enum.random(raffle.users).id)
  end
end
