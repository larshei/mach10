defmodule Mach10Web.RecordView do
  use Mach10Web, :view
  alias Mach10Web.RecordView

  def render("index.json", %{records: records}) do
    %{data: render_many(records, RecordView, "record.json")}
  end

  def render("show.json", %{record: record}) do
    %{data: render_one(record, RecordView, "record.json")}
  end

  def render("record.json", %{record: record}) do
    %{
      id: record.id,
      inserted_at: record.inserted_at,
      time_ms: record.time_ms,
      updated_at: record.updated_at,
    }
  end
end
