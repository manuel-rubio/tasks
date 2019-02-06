defmodule TasksWeb.UserController do
  use TasksWeb, :controller

  alias Tasks.{Auth, Token}

  action_fallback TasksWeb.FallbackController

  @doc """
       Register a new user.
       """
  def register(conn, %{"user" => user, "pass" => pass}) do
    creds = %{"user" => user, "pass" => pass}
    Auth.add(creds)
    {:ok, token, _claims} = Token.generate_and_sign(creds)
    render conn, "register.json", token: token
  end
end
