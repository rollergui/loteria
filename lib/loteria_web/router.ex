defmodule LoteriaWeb.Router do
  use LoteriaWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", LoteriaWeb do
    pipe_through :api
  end
end
