defmodule Flightex.Users.CreateOrUpdate do
  alias Flightex.Users.Agent, as: UserAgent
  alias Flightex.Users.User

  def call(%{id: id, name: name, email: email, cpf: cpf}) do
    id
    |> User.build(name, email, cpf)
    |> save_user()
  end

  defp save_user({:ok, %User{id: id} = user}) do
    UserAgent.save(user)
    {:ok, id}
  end

  defp save_user({:error, _reason}), do: {:error, "Cannot save user"}
end
