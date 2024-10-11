defmodule Loteria.Repo.Migrations.CreateRaffles do
  use Ecto.Migration

  def change do
    create table(:raffles) do
      add :name, :string
      add :draw_date, :date

      timestamps(type: :utc_datetime)
    end
  end
end
