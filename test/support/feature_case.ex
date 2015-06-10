defmodule TodoChannels.FeatureCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use TodoChannels.ConnCase
      use Hound.Helpers

      hound_session
    end
  end

  setup_all do
    System.cmd("ln", ["-s", "#{System.cwd}/client/dist/index.html", "../priv/static"], cd: "client")
    System.cmd("ln", ["-s", "#{System.cwd}/client/dist/assets", "../priv/static"], cd: "client")
    on_exit fn ->
      System.cmd("rm", ["index.html"], cd: "priv/static")
      System.cmd("rm", ["assets"], cd: "priv/static")
      :ok
    end
  end

  setup do
    TodoChannels.Endpoint.start_link
    :ok
  end
end
