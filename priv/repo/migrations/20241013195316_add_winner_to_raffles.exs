defmodule Loteria.Repo.Migrations.AddWinnerToRaffles do
  use Ecto.Migration

  def change do
    alter table(:raffles) do
      add :winner, references(:users, on_delete: :nothing)
    end
  end
end
