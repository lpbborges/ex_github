defmodule ExGithubWeb.FallbackController do
  use ExGithubWeb, :controller

  alias ExGithub.Error
  alias ExGithubWeb.ErrorView

  def call(conn, {:error, %Error{status: status, result: result}}) do
    conn
    |> put_status(status)
    |> put_view(ErrorView)
    |> render("error.json", result: result)
  end
end
