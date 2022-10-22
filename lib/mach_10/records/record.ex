defmodule Mach10.Records.Record do
  use Ecto.Schema
  import Ecto.Changeset

  schema "records" do
    field :time_ms, :integer
    field :track_id, :id
    field :user_id, :id

    timestamps(type: :utc_datetime, autogenerate: {Mach10.Helpers, :utc_now_no_usec, []})
  end

  @doc false
  def changeset(record, attrs) do
    record
    |> cast(attrs, [:time_ms])
    |> validate_required([:time_ms])
  end
end
