defmodule ExGithub.Github.ClientTest do
  use ExUnit.Case, async: true

  alias ExGithub.Error
  alias ExGithub.Github.Client
  alias Plug.Conn

  describe "get_user_repos/1" do
    setup do
      bypass = Bypass.open()

      {:ok, bypass: bypass}
    end

    # test "when there is a valid user, returns repos", %{bypass: bypass} do
    #   username = "lpbborges"

    #   url = endpoint_url(bypass.port)

    #   body = ~s([
    #     {
    #       "html_url": "https://github.com/lpbborges/be-the-hero",
    #       "id": 249_836_022,
    #       "name": "be-the-hero",
    #       "stargazers_count": 0
    #     },
    #     {
    #       "html_url": "https://github.com/lpbborges/blog-with-rails",
    #       "id": 254_991_833,
    #       "name": "blog-with-rails",
    #       "stargazers_count": 0
    #     }
    #   ]})

    #   Bypass.expect(bypass, "GET", "#{url}#{username}/repos/?per_page=2", fn conn ->
    #     conn
    #     |> Conn.put_resp_header("content-type", "application/json")
    #     |> Conn.resp(200, body)
    #   end)

    #   response = Client.get_user_repos(url, username)

    #   expected_response =
    #     {:ok,
    #      [
    #        %{
    #          "html_url" => "https://github.com/lpbborges/be-the-hero",
    #          "id" => 249_836_022,
    #          "name" => "be-the-hero",
    #          "stargazers_count" => 0
    #        },
    #        %{
    #          "html_url" => "https://github.com/lpbborges/blog-with-rails",
    #          "id" => 254_991_833,
    #          "name" => "blog-with-rails",
    #          "stargazers_count" => 0
    #        }
    #      ]}

    #   assert response == expected_response
    # end

    test "when not found the user, returns an error", %{bypass: bypass} do
      username = ""

      url = endpoint_url(bypass.port)

      Bypass.expect(bypass, "GET", "#{url}#{username}/repos/", fn conn ->
        conn
        |> Conn.resp(404, '')
      end)

      response = Client.get_user_repos(url, username)

      expected_response = {:error, %Error{result: "Not found", status: :not_found}}

      assert response == expected_response
    end

    defp endpoint_url(port), do: "http://localhost:#{port}/"
  end
end
