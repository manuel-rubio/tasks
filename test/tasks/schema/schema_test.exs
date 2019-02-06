defmodule Tasks.SchemaTest do
  use Tasks.DataCase

  alias Tasks.Schema

  describe "tasks" do
    alias Tasks.Schema.Task

    @valid_attrs %{content: "some content", priority: 42}
    @update_attrs %{content: "some updated content", priority: 43}
    @invalid_attrs %{content: nil, priority: nil}

    def task_fixture(attrs \\ %{}) do
      {:ok, task} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Schema.create_task()

      task
    end

    test "list_tasks/0 returns all tasks" do
      task = task_fixture()
      assert Schema.list_tasks() == [task]
    end

    test "get_task!/1 returns the task with given id" do
      task = task_fixture()
      assert Schema.get_task!(task.id) == task
    end

    test "create_task/1 with valid data creates a task" do
      assert {:ok, %Task{} = task} = Schema.create_task(@valid_attrs)
      assert task.content == "some content"
      assert task.priority == 42
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Schema.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = task_fixture()
      assert {:ok, task} = Schema.update_task(task, @update_attrs)
      assert %Task{} = task
      assert task.content == "some updated content"
      assert task.priority == 43
    end

    test "update_task/2 with invalid data returns error changeset" do
      task = task_fixture()
      assert {:error, %Ecto.Changeset{}} = Schema.update_task(task, @invalid_attrs)
      assert task == Schema.get_task!(task.id)
    end

    test "delete_task/1 deletes the task" do
      task = task_fixture()
      assert {:ok, %Task{}} = Schema.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> Schema.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = task_fixture()
      assert %Ecto.Changeset{} = Schema.change_task(task)
    end
  end
end
