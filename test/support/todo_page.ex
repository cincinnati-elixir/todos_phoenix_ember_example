defmodule TodoPage do
  use Hound.Helpers

  def url do
    System.get_env("TEST_ROOT_URL") || "http://localhost:4001/index.html"
  end

  def visit_page do
    navigate_to url
  end

  def add_todo(title) do
    find_element(:class, "new-todo")
    |> fill_field(title)
    send_keys :enter
  end
end

