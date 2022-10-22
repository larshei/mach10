defmodule Mach10.Records.Record do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  schema "records" do
    field :time_ms, :integer
    belongs_to(:user, Mach10.Users.User, primary_key: true)
    belongs_to(:track, Mach10.Tracks.Track, primary_key: true)

    timestamps(type: :utc_datetime, autogenerate: {Mach10.Helpers, :utc_now_no_usec, []})
  end

  @doc false
  def changeset(record, attrs) do
    record
    |> cast(attrs, [:time_ms, :track_id, :user_id])
    |> validate_required([:time_ms, :track_id, :user_id])
  end
end
