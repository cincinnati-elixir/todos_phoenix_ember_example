defmodule TodoChannels.TodoChannelTest do
  use TodoChannels.ChannelCase

  alias TodoChannels.TodoChannel

  setup do
    {:ok, _, socket} = subscribe_and_join(TodoChannel, "todos:list")
    {:ok, socket: socket}
  end

  test "broadcasts are pushed to the client", %{socket: socket} do
    broadcast_from! socket, "broadcast", %{"some" => "data"}
    assert_push "broadcast", %{"some" => "data"}
  end
end
