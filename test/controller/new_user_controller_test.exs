defmodule ChatElixir.Test.Controller.NewUserTest do
    @moduledoc """
    
    """

    use ExUnit.Case
    use Plug.Test

    alias ChatElixir.Web.Controller.NewUserController

    test "get params" do
        conn = post()
        resp = NewUserController.run(conn)
        IO.inspect resp
        assert true
    end

    defp post() do
        params = %{
                "user" => "nehonar",
                "email" => "nehonar@gmail.com",
                "password" => "123456"
            }
        conn(:post, "/new_user", params)
        |> put_req_header("content-type", "application/json")
    end
end