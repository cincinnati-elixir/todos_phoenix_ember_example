defmodule TodoChannels.Router do
  use TodoChannels.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TodoChannels do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/api", TodoChannels do
    pipe_through :api

    resources "/todos", TodoController
  end
end
