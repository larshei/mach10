defmodule Mach10.Repo.Migrations.CreateRecords do
  use Ecto.Migration

  def change do
    create table(:records, primary_key: false) do
      add :time_ms, :integer
      add :track_id, references(:tracks, on_delete: :nothing), primary_key: true
      add :user_id, references(:users, on_delete: :nothing), primary_key: true

      timestamps(type: :utc_datetime, autogenerate: {Mach10.Helpers, :utc_now_no_usec, []})
    end

    create unique_index(:records, [:track_id, :user_id])
  end
end
