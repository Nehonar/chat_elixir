defmodule ChatElixir.Test.Controller.CreateAccountTest do
    @moduledoc """
    
    """

    use ExUnit.Case
    use Plug.Test

    alias ChatElixir.Web.Controller.CreateAccountController

    test "get params" do
        conn = post()
        resp = CreateAccountController.run(conn)
        IO.inspect resp
        assert true#resp.resp_body == "ok"
    end

    test "username not valid" do
        conn = post_not_valid_user()
        resp = CreateAccountController.run(conn)

        assert Jason.decode!(resp.resp_body) == "Username not valid"
    end

    test "email not valid" do
        conn = post_not_valid_email()
        resp = CreateAccountController.run(conn)

        assert Jason.decode!(resp.resp_body) == "The email is not valid or not exist"
    end

    test "Password not valid" do
        conn = post_not_valid_pass()
        resp = CreateAccountController.run(conn)

        assert Jason.decode!(resp.resp_body) == "Password not valid"
    end

    defp post() do
        params = %{
                "username" => "nehonar",
                "email" => "nehonar@gmail.com",
                "password" => "123456"
            }
        conn(:post, "/create_account", params)
        |> put_req_header("content-type", "application/json")
    end

    defp post_not_valid_user() do
        params = %{
                "username" => "",
                "email" => "nehonar@gmail.com",
                "password" => "123456"
            }
        conn(:post, "/create_account", params)
        |> put_req_header("content-type", "application/json")
    end

    defp post_not_valid_email() do
        params = %{
                "username" => "",
                "email" => "estotienequeserfalsonehonar@gmail.com",
                "password" => "123456"
            }
        conn(:post, "/create_account", params)
        |> put_req_header("content-type", "application/json")
    end

    defp post_not_valid_pass() do
        params = %{
                "username" => "Nehonar",
                "email" => "nehonar@gmail.com",
                "password" => ""
            }
        conn(:post, "/create_account", params)
        |> put_req_header("content-type", "application/json")
    end
end