defmodule PontosWeb.Router do
  use PontosWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PontosWeb do
    pipe_through :api

    get "/", UserController, :index
  end
end
