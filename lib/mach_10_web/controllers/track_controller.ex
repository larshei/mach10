defmodule Mach10Web.TrackController do
  use Mach10Web, :controller

  alias Mach10.Tracks
  alias Mach10.Tracks.Track

  action_fallback Mach10Web.FallbackController

  def index(conn, _params) do
    tracks = Tracks.list_tracks()
    render(conn, "index.json", tracks: tracks)
  end

  def create(conn, track_params) do
    with {:ok, %Track{} = track} <- Tracks.create_track(track_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.track_path(conn, :show, track))
      |> render("show.json", track: track)
    end
  end

  def show(conn, %{"id" => id}) do
    track = Tracks.get_track!(id)
    render(conn, "show.json", track: track)
  end

  def update(conn, %{"id" => id, "track" => track_params}) do
    track = Tracks.get_track!(id)

    with {:ok, %Track{} = track} <- Tracks.update_track(track, track_params) do
      render(conn, "show.json", track: track)
    end
  end

  def delete(conn, %{"id" => id}) do
    track = Tracks.get_track!(id)

    with {:ok, %Track{}} <- Tracks.delete_track(track) do
      send_resp(conn, :no_content, "")
    end
  end
end
