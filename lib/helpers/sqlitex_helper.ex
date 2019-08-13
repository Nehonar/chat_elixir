defmodule ChatElixir.Helpers.SqlitexHelper do
    @moduledoc """
    
    """

    defmodule State do
        defstruct [
            :exec_state,
            :params,
            :path_sql_file,
            :sql,
            db_name_users: :db_users,
        ]
    end
    defmodule Error do
        defstruct [
            :reason,
            :state
        ]
    end

    defmodule CreateTable do
        @moduledoc """
        This module is helper to create the table.
        Only for the first time.
        """
        @path_create "lib/db/querys/create.sql"
        alias ChatElixir.Helpers.SqlitexHelper

        def run() do
            %State{path_sql_file: @path_create}
            |> SqlitexHelper.read_file()
            |> create_table()
            |> SqlitexHelper.return_resp()
        end

        def create_table(%State{sql: sql, db_name_users: db_name_users} = state) do
            case Sqlitex.Server.exec(db_name_users, sql) do
                :ok -> 
                    %State{state | exec_state: :ok}
                {:error, {_error_type, reason}} ->
                    %Error{reason: reason, state: state}
            end
        end
        def create_table(%Error{} = error), do: error
    end

    defmodule InsertData do
        @moduledoc """
        This module is helper to insert info in db
        """
        @path_insert "lib/db/querys/insert.sql"
        alias ChatElixir.Helpers.SqlitexHelper

        def run(params) do
            %State{params: params, path_sql_file: @path_insert}
            |> SqlitexHelper.read_file()
            |> create_sql()
            |> insert_params()
            |> SqlitexHelper.return_resp()
        end

        def create_sql(%State{params: params, sql: sql} = state) do
            sql_complete =
                sql <> "(" <> ~s('#{params["username"]}', '#{params["email"]}', '#{params["password"]}') <> ")"
            
            %State{state | sql: sql_complete}
        end
        def create_sql(%Error{} = error), do: error

        def insert_params(%State{sql: sql, db_name_users: db_name_users} = state) do
            case Sqlitex.Server.exec(db_name_users, sql) do
                :ok -> 
                    %State{state | exec_state: :ok}
                {:error, {:constraint, _reason}} ->
                    %Error{reason: "Username already exist", state: state}
            end
        end
        def insert_params(%Error{} = error), do: %{reason: error.reason, state: error.state}
    end

    defmodule Update_data do
        @moduledoc """
        TODO
        """
    end

    def read_file(%State{path_sql_file: path_file_read} = state) do
        case File.read(path_file_read) do
            {:ok, sql} -> 
                %State{state | sql: sql}
            _error ->
                %Error{reason: "I can't read the file to create a table", state: state}
        end
    end

    def return_resp(%State{} = state), do: {:ok, state}
    def return_resp(%Error{} = error), do: {:error, error}
end