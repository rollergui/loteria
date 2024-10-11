defmodule LoteriaWeb.Router do
  use LoteriaWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", LoteriaWeb do
    pipe_through :api

    resources "/users", UserController, except: [:new, :edit]
    resources "/raffles", RaffleController, except: [:new, :edit]
  end
end
