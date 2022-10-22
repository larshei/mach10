defmodule Mach10.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :deleted_at, :utc_datetime
    field :image_url, :string
    field :last_seen_at, :utc_datetime
    field :name, :string

    timestamps(type: :utc_datetime, autogenerate: {Mach10.Helpers, :utc_now_no_usec, []})
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :image_url, :deleted_at, :last_seen_at])
    |> validate_required([:name])
  end
end
