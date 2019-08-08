defmodule ChatElixir.Application do
    @moduledoc """
    Documentation for ChatElixir.
    """
    use Application
  
    import Supervisor.Spec

    alias Plug.Cowboy
    alias ChatElixir.Web.Router
  
    def start(_type, _args) do
        children = [
            Cowboy.child_spec(
                scheme: :http,
                plug: Router,
                options: [port: 4001]
            ),
            worker(Sqlitex.Server, [
                "lib/db/users.sqlite3", [name: :db_users]
            ])
        ]
  
        opts = [strategy: :one_for_one, name: ChatElixir.Supervisor]
        Supervisor.start_link(children, opts)
    end
  end