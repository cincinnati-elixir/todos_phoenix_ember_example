defmodule TodoChannels.Todo do
  use TodoChannels.Web, :model

  schema "todos" do
    field :title, :string
    field :is_completed, :boolean, default: false

    timestamps
  end

  @required_fields ~w(title is_completed)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If `params` are nil, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end

#defimpl Poison.Encoder, for: TodoChannels.Todo do
#  def encode(todo, _options) do
#    %{id: "#{todo.id}",
#      title: todo.title,
#      isCompleted: todo.is_completed
#     } |> Poison.Encoder.encode([])
#  end
#end
