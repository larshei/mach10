defmodule Mach10.Users do
  @moduledoc """
  The Users context.
  """

  import Ecto.Query, warn: false
  alias Mach10.Repo

  alias Mach10.Users.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user(id), do: Repo.get(User, id)
  def get_user!(id), do: Repo.get!(User, id)
  def get_user_by_reference(reference), do: Repo.get_by(User, reference: reference)
  def get_user_by_reference!(reference), do: Repo.get_by!(User, reference: reference)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    {ok, user} = result = %User{}
    |> User.changeset(attrs)
    |> Repo.insert()

    if ok == :ok do
      Phoenix.PubSub.broadcast(Mach10.PubSub, "users", {:user, :inserted, user})
    end

    result
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    {ok, user} = result = user
    |> User.changeset(attrs)
    |> Repo.update()

    if ok == :ok do
      Phoenix.PubSub.broadcast(Mach10.PubSub, "users", {:user, :updated, user})
    end

    result
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}
  """
  def delete_user(%User{} = user) do
    {ok, user} = result = Repo.delete(user)

    if ok == :ok do
      Phoenix.PubSub.broadcast(Mach10.PubSub, "users", {:user, :deleted, user})
    end

    result
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end
end
