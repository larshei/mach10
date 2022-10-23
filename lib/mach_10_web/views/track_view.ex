defmodule Mach10Web.TrackView do
  use Mach10Web, :view
  alias Mach10Web.TrackView

  def render("index.json", %{tracks: tracks}) do
    %{data: render_many(tracks, TrackView, "track.json")}
  end

  def render("show.json", %{track: track}) do
    %{data: render_one(track, TrackView, "track.json")}
  end

  def render("track.json", %{track: track}) do
    %{
      deleted_at: track.deleted_at,
      id: track.id,
      image_url: track.image_url,
      inserted_at: track.inserted_at,
      name: track.name,
      reference: track.reference,
      updated_at: track.updated_at,
    }
  end
end
