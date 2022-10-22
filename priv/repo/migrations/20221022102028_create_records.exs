defmodule Mach10.Repo.Migrations.CreateRecords do
  use Ecto.Migration

  def change do
    create table(:records) do
      add :time_ms, :integer
      add :track_id, references(:tracks, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)

      timestamps(type: :utc_datetime, autogenerate: {Mach10.Helpers, :utc_now_no_usec, []})
    end

    create index(:records, [:track_id])
    create index(:records, [:user_id])
  end
end
