defmodule LoteriaWeb.RaffleController do
  use LoteriaWeb, :controller

  alias Loteria.Raffles
  alias Loteria.Raffles.Raffle

  action_fallback LoteriaWeb.FallbackController

  def index(conn, _params) do
    raffles = Raffles.list_raffles()
    render(conn, :index, raffles: raffles)
  end

  def create(conn, %{"raffle" => raffle_params}) do
    with {:ok, %Raffle{} = raffle} <- Raffles.create_raffle(raffle_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/raffles/#{raffle}")
      |> render(:show, raffle: raffle)
    end
  end

  def show(conn, %{"id" => id}) do
    raffle = Raffles.get_raffle!(id)
    render(conn, :show, raffle: raffle)
  end

  def update(conn, %{"id" => id, "raffle" => raffle_params}) do
    raffle = Raffles.get_raffle!(id)

    with {:ok, %Raffle{} = raffle} <- Raffles.update_raffle(raffle, raffle_params) do
      render(conn, :show, raffle: raffle)
    end
  end

  def delete(conn, %{"id" => id}) do
    raffle = Raffles.get_raffle!(id)

    with {:ok, %Raffle{}} <- Raffles.delete_raffle(raffle) do
      send_resp(conn, :no_content, "")
    end
  end
end
