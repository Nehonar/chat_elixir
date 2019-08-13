defmodule ChatElixir.Test.Controller.NewUserTest do
    @moduledoc """
    
    """

    use ExUnit.Case
    use Plug.Test

    alias ChatElixir.Web.Controller.NewUserController

    test "get params" do
        conn = post()
        resp = NewUserController.run(conn)
        
        assert resp.resp_body == "ok"
    end

    test "username not valid" do
        conn = post_not_valid_user()
        resp = NewUserController.run(conn)

        assert Jason.decode!(resp.resp_body) == "Username not valid"
    end

    test "email not valid" do
        conn = post_not_valid_email()
        resp = NewUserController.run(conn)

        assert Jason.decode!(resp.resp_body) == "The email is not valid or not exist"
    end

    test "Password not valid" do
        conn = post_not_valid_pass()
        resp = NewUserController.run(conn)

        assert Jason.decode!(resp.resp_body) == "Password not valid"
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

    defp post_not_valid_user() do
        params = %{
                "user" => "",
                "email" => "nehonar@gmail.com",
                "password" => "123456"
            }
        conn(:post, "/new_user", params)
        |> put_req_header("content-type", "application/json")
    end

    defp post_not_valid_email() do
        params = %{
                "user" => "",
                "email" => "estotienequeserfalsonehonar@gmail.com",
                "password" => "123456"
            }
        conn(:post, "/new_user", params)
        |> put_req_header("content-type", "application/json")
    end

    defp post_not_valid_pass() do
        params = %{
                "user" => "Nehonar",
                "email" => "nehonar@gmail.com",
                "password" => ""
            }
        conn(:post, "/new_user", params)
        |> put_req_header("content-type", "application/json")
    end
end