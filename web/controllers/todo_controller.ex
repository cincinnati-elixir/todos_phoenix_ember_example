defmodule TodoChannels.TodoController do
  use TodoChannels.Web, :controller

  alias TodoChannels.Todo
  alias TodoChannels.TodoView

  plug :scrub_params, "data" when action in [:create, :update]
  plug :action

  def index(conn, _params) do
    todos = Repo.all(Todo)
    render(conn, "index.json", todos: todos)
  end

  def create(conn, %{"data" => payload}) do
    todo_params = Dict.get(payload, "attributes")
    changeset = Todo.changeset(%Todo{}, todo_params)

    if changeset.valid? do
      todo = Repo.insert(changeset)
      TodoChannels.Endpoint.broadcast! "todos:list", "todo", TodoView.render("show.json", %{todo: todo})
      conn
        |> put_status(201) # 201 is the proper status code for a created resource
        |> render "show.json", todo: todo
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(TodoChannels.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    todo = Repo.get(Todo, id)
    render conn, "show.json", todo: todo
  end

  def update(conn, %{"id" => id, "data" => payload}) do
    todo = Repo.get(Todo, id)
    todo_params = Dict.get(payload, "attributes")
    changeset = Todo.changeset(todo, todo_params)

    if changeset.valid? do
      todo = Repo.update(changeset)
      TodoChannels.Endpoint.broadcast! "todos:list", "todo", TodoView.render("show.json", %{todo: todo})
      render(conn, "show.json", todo: todo)
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(TodoChannels.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    todo = Repo.get(Todo, id)

    todo = Repo.delete(todo)
    TodoChannels.Endpoint.broadcast! "todos:list", "deleted_todo", TodoView.render("show.json", %{todo: todo})
    render(conn, "show.json", todo: todo)
  end
end
