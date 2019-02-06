defmodule Tasks.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :content, :string
      add :priority, :integer

      timestamps()
    end

  end
end
