defmodule TodoChannels.TodoView do
  use TodoChannels.Web, :view

  def render("index.json", %{todos: todos}) do
    %{data: render_many(todos, "todo.json")}
  end

  def render("show.json", %{todo: todo}) do
    %{data: render_one(todo, "todo.json")}
  end

  def render("todo.json", %{todo: todo}) do
    %{id: todo.id, type: "todo", attributes: render_one(todo, "todo_attrs.json")}
  end

  def render("todo_attrs.json", %{todo: todo}) do
    %{ title: todo.title, is_completed: todo.is_completed}
  end
end
