ExUnit.start

# Create the database, run migrations, and start the test transaction.
Mix.Task.run "ecto.create", ["--quiet"]
Mix.Task.run "ecto.migrate", ["--quiet"]
Ecto.Adapters.SQL.begin_test_transaction(TodoChannels.Repo)
System.cmd("#{System.cwd}/client/node_modules/ember-cli/bin/ember", ["build", "--environment=ci"], cd: "client")

