defmodule Mach10Web.IndexLive do
  use Mach10Web, :live_view

  alias Mach10.Tracks
  alias Mach10.Users

  @impl true
  def mount(_params, _session, socket) do
    tracks = Tracks.list_tracks()
    users = Users.list_users()

    {:ok,
      assign(socket, users: users, tracks: tracks)
    }
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Mach10Web.Components.Layout.layout selected_menu_item="Home">

    </Mach10Web.Components.Layout.layout>
    """
  end
end
