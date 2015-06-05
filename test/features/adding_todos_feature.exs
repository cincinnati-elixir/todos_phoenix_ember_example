defmodule TodoChannels.AddingTodosFeature do
  use TodoChannels.ConnCase
  use Hound.Helpers

  hound_session

  setup do
    TodoChannels.Endpoint.start_link
    :ok
  end

  test "Navigating to the app." do
    TodoPage.visit_page
    assert current_url == "http://localhost:4100/"
  end

  test "Adding a Todo." do
    TodoPage.visit_page
    TodoPage.add_todo("A new Hound Todo")

    assert String.contains?(page_source, "A new Hound Todo")
  end


  test "connected clients see todos added in realtime" do
    TodoPage.visit_page

   change_session_to(:session_two)
   TodoPage.visit_page

   in_browser_session(:session_two, fn ->
     TodoPage.add_todo("Todo from Session 2")
     assert String.contains?(page_source, "Todo from Session 2")
   end)

    in_browser_session(:default, fn ->
      TodoPage.add_todo("Todo from Session 1")
      assert String.contains?(page_source, "Todo from Session 2")
    end)

    in_browser_session(:session_two, fn ->
      assert String.contains?(page_source, "Todo from Session 2")
    end)
  end
end

