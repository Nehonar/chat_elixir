defmodule ChatElixir.Web.Router do
    @moduledoc """
    
    """
    use Plug.Router

    alias ChatElixir.Web.Controller.{PingController, NewUserController}

    plug(:match)
    plug(:dispatch)

    # GET
    get "/ping",    do: PingController.ping(conn)
    get "/flunk",   do: PingController.flunk(conn)

    # POST
    post "/new_user",   do: NewUserController.run(conn)

    match _ do
        send_resp(conn, 404, "Not today Satan...not today...")
    end
end