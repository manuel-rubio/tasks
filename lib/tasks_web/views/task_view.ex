defmodule TasksWeb.TaskView do
  use TasksWeb, :view

  def prio2txt(1), do: "high"
  def prio2txt(2), do: "medium"
  def prio2txt(3), do: "low"
end
