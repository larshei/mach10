defmodule Mach10.TracksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Mach10.Tracks` context.
  """

  @doc """
  Generate a track.
  """
  def track_fixture(attrs \\ %{}) do
    {:ok, track} =
      attrs
      |> Enum.into(%{
        deleted_at: ~U[2022-10-21 10:20:00Z],
        image_url: "some image_url",
        name: "some name"
      })
      |> Mach10.Tracks.create_track()

    track
  end
end
