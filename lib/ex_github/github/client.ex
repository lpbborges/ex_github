defmodule ExGithub.Github.Client do
  use Tesla

  alias ExGithub.Error
  alias Tesla.Env

  @base_url "https://api.github.com/users/"
  plug Tesla.Middleware.Headers, [{"user-agent", "Tesla"}]
  plug Tesla.Middleware.JSON

  def get_user_repos(url \\ @base_url, username) do
    "#{url}#{username}/repos"
    |> get()
    |> handle_get()
  end

  defp handle_get({:ok, %Env{status: 200, body: body}}) do
    repos = Enum.map(body, fn element -> handle_repo(element) end)

    {:ok, repos}
  end

  defp handle_get({:ok, %Env{status: 404, body: _body}}) do
    {:error, Error.build(:not_found, "Not found")}
  end

  defp handle_repo(%{
         "id" => id,
         "name" => name,
         "html_url" => html_url,
         "stargazers_count" => stargazers_count
       }) do
    %{
      "id" => id,
      "name" => name,
      "html_url" => html_url,
      "stargazers_count" => stargazers_count
    }
  end
end
