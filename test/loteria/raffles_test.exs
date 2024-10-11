defmodule Loteria.RafflesTest do
  use Loteria.DataCase

  alias Loteria.Raffles

  describe "raffles" do
    alias Loteria.Raffles.Raffle

    import Loteria.RafflesFixtures

    @invalid_attrs %{draw_date: nil, name: nil}

    test "list_raffles/0 returns all raffles" do
      raffle = raffle_fixture()
      assert Raffles.list_raffles() == [raffle]
    end

    test "get_raffle!/1 returns the raffle with given id" do
      raffle = raffle_fixture()
      assert Raffles.get_raffle!(raffle.id) == raffle
    end

    test "create_raffle/1 with valid data creates a raffle" do
      valid_attrs = %{draw_date: ~D[2024-10-10], name: "some name"}

      assert {:ok, %Raffle{} = raffle} = Raffles.create_raffle(valid_attrs)
      assert raffle.draw_date == ~D[2024-10-10]
      assert raffle.name == "some name"
    end

    test "create_raffle/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Raffles.create_raffle(@invalid_attrs)
    end

    test "update_raffle/2 with valid data updates the raffle" do
      raffle = raffle_fixture()
      update_attrs = %{draw_date: ~D[2024-10-11], name: "some updated name"}

      assert {:ok, %Raffle{} = raffle} = Raffles.update_raffle(raffle, update_attrs)
      assert raffle.draw_date == ~D[2024-10-11]
      assert raffle.name == "some updated name"
    end

    test "update_raffle/2 with invalid data returns error changeset" do
      raffle = raffle_fixture()
      assert {:error, %Ecto.Changeset{}} = Raffles.update_raffle(raffle, @invalid_attrs)
      assert raffle == Raffles.get_raffle!(raffle.id)
    end

    test "delete_raffle/1 deletes the raffle" do
      raffle = raffle_fixture()
      assert {:ok, %Raffle{}} = Raffles.delete_raffle(raffle)
      assert_raise Ecto.NoResultsError, fn -> Raffles.get_raffle!(raffle.id) end
    end

    test "change_raffle/1 returns a raffle changeset" do
      raffle = raffle_fixture()
      assert %Ecto.Changeset{} = Raffles.change_raffle(raffle)
    end
  end
end
