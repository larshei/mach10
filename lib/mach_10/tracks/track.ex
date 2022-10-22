defmodule Mach10.Tracks.Track do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tracks" do
    field :deleted_at, :utc_datetime
    field :image_url, :string
    field :name, :string

    timestamps(type: :utc_datetime, autogenerate: {Mach10.Helpers, :utc_now_no_usec, []})
  end

  @doc false
  def changeset(track, attrs) do
    track
    |> cast(attrs, [:name, :image_url, :deleted_at])
    |> validate_required([:name])
  end
end
