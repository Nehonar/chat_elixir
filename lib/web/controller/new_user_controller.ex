defmodule ChatElixir.Web.Controller.NewUserController do
    @moduledoc """
    
    """
    import Plug.Conn

    defmodule State do
        defstruct [
            :conn,
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
        |> check_password()
        |> send_respond()
    end

    def get_params(%State{conn: conn} = state) do
        params = 
            conn.body_params
        IO.inspect params
        %State{state | params: params}
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

    def check_username(%State{params: %{"user" => user}} = state) 
        when is_binary(user) and byte_size(user) > 0 do 
            
        state # Return state
    end
    def check_username(%State{} = state) do 
        %Error{reason: "Username not valid", state: state}
    end
    def check_username(error), do: error

    def check_password(%State{params: %{"password" => pass}} = state)
        when byte_size(pass) > 0 do
            
        state # Return state
    end
    def check_password(%State{} = state) do
        %Error{reason: "Password not valid", state: state}
    end
    def check_password(%Error{} = error), do: error

    def send_respond(%State{conn: conn}) do
        conn
        |> put_resp_header("content-type", "application/json")
        |> send_resp(200, "ok")
    end
    def send_respond(%Error{reason: reason, state: state}) do
        state.conn
        |> put_resp_header("content-type", "plain/text")
        |> send_resp(422, Jason.encode!(reason))
    end
end