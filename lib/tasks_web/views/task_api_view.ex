defmodule TasksWeb.TaskApiView do
  use TasksWeb, :view
  alias TasksWeb.TaskApiView
  import TasksWeb.TaskView, only: [prio2txt: 1]

  def render("index.json", %{tasks: tasks}) do
    %{data: render_many(tasks, TaskApiView, "task.json")}
  end

  def render("show.json", %{task: task}) do
    %{data: render_one(task, TaskApiView, "task.json")}
  end

  def render("task.json", %{task_api: task}) do
    %{id: task.id, priority: prio2txt(task.priority), content: task.content}
  end
end
