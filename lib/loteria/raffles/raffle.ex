defmodule Loteria.Raffles.Raffle do
  use Ecto.Schema
  import Ecto.Changeset

  schema "raffles" do
    field :draw_date, :date
    field :name, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(raffle, attrs) do
    raffle
    |> cast(attrs, [:name, :draw_date])
    |> validate_required([:name, :draw_date])
  end
end
