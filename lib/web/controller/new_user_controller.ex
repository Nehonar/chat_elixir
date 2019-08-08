defmodule ChatElixir.Web.Controller.NewUserController do
    @moduledoc """
    
    """
    import Plug.Conn

    defmodule State do
        defstruct [
            :conn,
            :data,
            :params
        ]
    end
    defmodule Error do
        defstruct [
            :reason,
            :state
        ] 
    end
    # TODO
    # def run(%{}) do
        
    # end
    def run(conn) do
        %State{conn: conn}
        |> struct()
        |> get_params()
        |> check_email()
        |> check_username()
        |> send_respond()
    end

    def get_params(%State{conn: conn} = state) do
        params = 
            conn.body_params
            
        %State{state | params: params, data: params}
    end

    def check_email(%State{params: %{"email" => email}} = state) do
        with true <- EmailChecker.valid?(email, [EmailChecker.Check.Format]),
             true <- EmailChecker.Check.SMTP.valid?(email)
        do
            state
        else
            _error -> %Error{reason: "The email is not valid or not exist", state: state}
        end
    end

    def check_username(%State{}) do
        
    end
    def check_username(error), do: error

    def send_respond(%State{conn: conn, data: data}) do
        conn
        |> put_resp_header("content-type", "application/json")
        |> send_resp(200, Jason.encode!(data))
    end
    def send_respond(%Error{reason: reason, state: state}) do
        state.conn
        |> put_resp_header("content-type", "plain/text")
        |> send_resp(422, Jason.encode!(reason))
    end
end