defmodule ChatElixir.Web.Router do
    @moduledoc """
    
    """
    use Plug.Router

    alias ChatElixir.Web.Controller.{PingController, CreateAccountController}

    plug(:match)
    plug(:dispatch)

    # GET
    get "/ping",    do: PingController.ping(conn)
    get "/flunk",   do: PingController.flunk(conn)

    # POST
    post "/create_account",     do: CreateAccountController.run(conn)
    post "/sign_in",            do: SignInController.run(conn)

    match _ do
        send_resp(conn, 404, "Not today Satan...not today...")
    end
end