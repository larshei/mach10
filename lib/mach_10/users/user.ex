defmodule Mach10.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :deleted_at, :utc_datetime
    field :image_url, :string
    field :last_seen_at, :utc_datetime
    field :name, :string
    field :reference, :string
    has_many(:records, Mach10.Records.Record)

    timestamps(type: :utc_datetime, autogenerate: {Mach10.Helpers, :utc_now_no_usec, []})
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:reference, :name, :image_url, :deleted_at, :last_seen_at])
    |> validate_required([:reference, :name])
  end
end
