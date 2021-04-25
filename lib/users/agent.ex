defmodule Flightex.Users.Agent do
  alias Flightex.Users.User

  use Agent

  def start_link(_initial_state \\ %{}) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def save(%User{} = user) do
    Agent.update(__MODULE__, &update_state(&1, user))
  end

  def get(id) do
    Agent.get(__MODULE__, &get_user(&1, id))
  end

  def is_valid_user(id) do
    case get(id) do
      {:ok, _user} -> true
      {:error, _reason} -> false
    end
  end

  defp update_state(state, %User{id: id} = user), do: Map.put(state, id, user)

  defp get_user(state, id) do
    case Map.get(state, id) do
      nil -> {:error, "User not exist"}
      user -> {:ok, user}
    end
  end
end
