defmodule Mach10Web.RecordView do
  use Mach10Web, :view
  alias Mach10Web.RecordView

  alias Mach10.Users.User
  alias Mach10.Tracks.Track

  def render("index.json", %{records: records}) do
    %{data: render_many(records, RecordView, "record.json")}
  end

  def render("show.json", %{record: record}) do
    %{data: render_one(record, RecordView, "record.json")}
  end

  def render("record.json", %{record: %{track: %Track{}, user: %User{}} = record}) do
    %{
      track: %{id: record.track.id, name: record.track.name},
      user: %{id: record.user.id, name: record.user.name},
      inserted_at: record.inserted_at,
      time_ms: record.time_ms,
      updated_at: record.updated_at,
    }
  end
  def render("record.json", %{record: record}) do
    %{
      track: %{id: record.track_id},
      user: %{id: record.user_id},
      inserted_at: record.inserted_at,
      time_ms: record.time_ms,
      updated_at: record.updated_at,
    }
  end
end
