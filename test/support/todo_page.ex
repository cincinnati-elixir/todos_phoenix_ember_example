defmodule TodoPage do
  use Hound.Helpers

  def visit_page do
    navigate_to "http://localhost:4100/"
  end

  def add_todo(title) do
    find_element(:class, "new-todo")
    |> fill_field(title)
    send_keys :enter
  end
end

