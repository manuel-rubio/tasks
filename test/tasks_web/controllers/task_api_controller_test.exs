defmodule TasksWeb.TaskApiControllerTest do
  use TasksWeb.ConnCase

  alias Tasks.Schema
  alias Tasks.Schema.TaskApi

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:task_api) do
    {:ok, task_api} = Schema.create_task_api(@create_attrs)
    task_api
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all tasks", %{conn: conn} do
      conn = get conn, task_api_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create task_api" do
    test "renders task_api when data is valid", %{conn: conn} do
      conn = post conn, task_api_path(conn, :create), task_api: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, task_api_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, task_api_path(conn, :create), task_api: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update task_api" do
    setup [:create_task_api]

    test "renders task_api when data is valid", %{conn: conn, task_api: %TaskApi{id: id} = task_api} do
      conn = put conn, task_api_path(conn, :update, task_api), task_api: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, task_api_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id}
    end

    test "renders errors when data is invalid", %{conn: conn, task_api: task_api} do
      conn = put conn, task_api_path(conn, :update, task_api), task_api: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete task_api" do
    setup [:create_task_api]

    test "deletes chosen task_api", %{conn: conn, task_api: task_api} do
      conn = delete conn, task_api_path(conn, :delete, task_api)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, task_api_path(conn, :show, task_api)
      end
    end
  end

  defp create_task_api(_) do
    task_api = fixture(:task_api)
    {:ok, task_api: task_api}
  end
end
