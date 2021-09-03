defmodule ExGithub do
  alias ExGithub.Users.Create, as: UserCreate
  alias ExGithub.Users.Get, as: UsersGet

  defdelegate create_user(params), to: UserCreate, as: :call
  defdelegate get_user_by_id(id), to: UsersGet, as: :by_id
end
