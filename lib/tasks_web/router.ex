defmodule TasksWeb.Router do
  use TasksWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TasksWeb do
    pipe_through :browser # Use the default browser stack

    get "/", TaskController, :index
    resources "/tasks", TaskController, except: [:index]
  end

  scope "/api", TasksWeb do
    pipe_through :api

    resources "/tasks", TaskApiController, except: [:new, :edit]
    post "/register", UserController, :register
  end
end
