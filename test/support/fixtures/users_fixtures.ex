defmodule Mach10.UsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Mach10.Users` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        deleted_at: ~U[2022-10-21 10:20:00Z],
        image_url: "some image_url",
        last_seen_at: ~U[2022-10-21 10:20:00Z],
        name: "some name"
      })
      |> Mach10.Users.create_user()

    user
  end
end
