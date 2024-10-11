defmodule Loteria.RafflesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Loteria.Raffles` context.
  """

  @doc """
  Generate a raffle.
  """
  def raffle_fixture(attrs \\ %{}) do
    {:ok, raffle} =
      attrs
      |> Enum.into(%{
        draw_date: ~D[2024-10-10],
        name: "some name"
      })
      |> Loteria.Raffles.create_raffle()

    raffle
  end
end
