defmodule ExGithub.Repo do
  use Ecto.Repo,
    otp_app: :ex_github,
    adapter: Ecto.Adapters.Postgres
end
