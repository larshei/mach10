defmodule Mach10.Repo.Migrations.CreateTracks do
  use Ecto.Migration

  def change do
    create table(:tracks) do
      add :name, :string
      add :image_url, :string
      add :deleted_at, :utc_datetime
      add :reference, :string

      timestamps(type: :utc_datetime, autogenerate: {Mach10.Helpers, :utc_now_no_usec, []})
    end

    create unique_index(:tracks, [:reference])
  end
end
