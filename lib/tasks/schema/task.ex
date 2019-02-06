defmodule Tasks.Schema.Task do
  use Ecto.Schema
  import Ecto.Changeset


  schema "tasks" do
    field :content, :string
    field :priority, :integer

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:content, :priority])
    |> validate_required([:content, :priority])
    |> validate_number(:priority,
                       greater_than_or_equal_to: 1,
                       less_than_or_equal_to: 3)
  end
end
