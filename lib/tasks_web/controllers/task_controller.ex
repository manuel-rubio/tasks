defmodule TasksWeb.TaskController do
  use TasksWeb, :controller

  alias Tasks.Schema
  alias Tasks.Schema.Task

  @doc """
       Show the list of tasks.
       """
  def index(conn, _params) do
    tasks = Schema.list_tasks()
    render(conn, "index.html", tasks: tasks)
  end

  @doc """
       Show us a form to add a new task.
       """
  def new(conn, _params) do
    changeset = Schema.change_task(%Task{})
    render(conn, "new.html", changeset: changeset)
  end

  @doc """
       Receive the form from `new` and create the task or
       return an error if an error happened
       """
  def create(conn, %{"task" => task_params}) do
    case Schema.create_task(task_params) do
      {:ok, _task} ->
        conn
        |> put_flash(:info, "Task created successfully.")
        |> redirect(to: task_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  @doc """
       Show us a task.
       """
  def show(conn, %{"id" => id}) do
    task = Schema.get_task!(id)
    render(conn, "show.html", task: task)
  end

  @doc """
       Show us a form to edit a task.
       """
  def edit(conn, %{"id" => id}) do
    task = Schema.get_task!(id)
    changeset = Schema.change_task(task)
    render(conn, "edit.html", task: task, changeset: changeset)
  end

  @doc """
       Update the information received from `edit` for the task.
       """
  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Schema.get_task!(id)

    case Schema.update_task(task, task_params) do
      {:ok, _task} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: task_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", task: task, changeset: changeset)
    end
  end

  @doc """
       Removes a task.
       """
  def delete(conn, %{"id" => id}) do
    task = Schema.get_task!(id)
    {:ok, _task} = Schema.delete_task(task)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: task_path(conn, :index))
  end
end
