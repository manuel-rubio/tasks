defmodule TasksWeb.UserView do
  use TasksWeb, :view
  alias TasksWeb.UserView

  def render("register.json", %{token: token}) do
    %{token: token}
  end
end
