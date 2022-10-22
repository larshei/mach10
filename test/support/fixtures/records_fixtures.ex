defmodule Mach10.RecordsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Mach10.Records` context.
  """

  @doc """
  Generate a record.
  """
  def record_fixture(attrs \\ %{}) do
    {:ok, record} =
      attrs
      |> Enum.into(%{
        time_ms: 42
      })
      |> Mach10.Records.create_record()

    record
  end
end
