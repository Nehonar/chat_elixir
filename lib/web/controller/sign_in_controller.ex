defmodule ChatElixir.Web.Controller.SignInController do
    @moduledoc """
    
    """
    alias ChatElixir.Helpers.SqlitexHelper.InsertData

    defmodule State do
        defstruct [
            :params,
            :conn
        ]
    end

    defmodule Error do
        defstruct [
            :reason,
            :state
        ]
    end

    def run(conn) do
        %State{conn: conn}
        
    end
end