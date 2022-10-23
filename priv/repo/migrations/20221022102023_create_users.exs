defmodule Mach10.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :image_url, :string
      add :deleted_at, :utc_datetime
      add :last_seen_at, :utc_datetime
      add :reference, :string

      timestamps(type: :utc_datetime, autogenerate: {Mach10.Helpers, :utc_now_no_usec, []})
    end

    create unique_index(:users, [:reference])
  end
end
