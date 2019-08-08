defmodule ChatElixir.Web.Controller.PingController do
    @moduledoc """
    
    """
    alias Plug.Conn

    def ping(conn) do
        conn
        |> Conn.put_resp_header("content-type", "text/plain")
        |> Conn.send_resp(200, "Pang...pung")
    end

    def flunk(conn) do
        conn
        |> Conn.put_resp_header("content-type", "text/plain")
        |> Conn.send_resp(500, "Wait...what??\nThats not exist")
    end
end