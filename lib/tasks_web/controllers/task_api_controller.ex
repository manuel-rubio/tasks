defmodule TasksWeb.TaskApiController do
  use TasksWeb, :controller

  alias Tasks.Schema
  alias Tasks.Schema.Task

  action_fallback TasksWeb.FallbackController

  defp txt2prio("high"), do: 1
  defp txt2prio("medium"), do: 2
  defp txt2prio("low"), do: 3
  defp txt2prio(_), do: 0

  def index(conn, %{"priority" => priority}) do
    tasks = Schema.list_tasks(priority: txt2prio(priority))
    render(conn, "index.json", tasks: tasks)
  end
  def index(conn, params) do
    tasks = Schema.list_tasks()
    render(conn, "index.json", tasks: tasks)
  end

  def create(conn, %{"task" => task_params}) do
    with {:ok, %Task{} = task} <- Schema.create_task(task_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", task_api_path(conn, :show, task))
      |> render("show.json", task: task)
    end
  end

  def show(conn, %{"id" => id}) do
    task = Schema.get_task!(id)
    render(conn, "show.json", task: task)
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Schema.get_task!(id)

    with {:ok, %Task{} = task} <- Schema.update_task(task, task_params) do
      render(conn, "show.json", task: task)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Schema.get_task!(id)
    with {:ok, %Task{}} <- Schema.delete_task(task) do
      send_resp(conn, :no_content, "")
    end
  end
end
