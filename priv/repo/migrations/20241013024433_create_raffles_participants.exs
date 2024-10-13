defmodule Loteria.Repo.Migrations.CreateRafflesUsers do
  use Ecto.Migration

  def change do
    create table(:raffles_users, primary_key: false) do
      add :raffle_id, references(:raffles, on_delete: :nothing), primary_key: true
      add :user_id, references(:users, on_delete: :nothing), primary_key: true

      timestamps(type: :utc_datetime)
    end

    create index(:raffles_users, [:raffle_id])
    create unique_index(:raffles_users, [:raffle_id, :user_id])
  end
end
