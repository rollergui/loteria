defmodule LoteriaWeb.RaffleJSON do
  alias Loteria.Raffles.Raffle

  @doc """
  Renders a list of raffles.
  """
  def index(%{raffles: raffles}) do
    %{data: for(raffle <- raffles, do: data(raffle))}
  end

  @doc """
  Renders a single raffle.
  """
  def show(%{raffle: raffle}) do
    %{data: data(raffle)}
  end

  def result(%{user: user}) do
    LoteriaWeb.UserJSON.show(%{user: user})
  end

  def error(%{message: message}), do: %{error: message}

  defp data(%Raffle{} = raffle) do
    %{
      id: raffle.id,
      name: raffle.name,
      draw_date: raffle.draw_date
    }
  end
end
