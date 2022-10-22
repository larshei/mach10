defmodule Mach10Web.TracksLive do
  use Mach10Web, :live_view

  alias Mach10.Tracks
  alias Mach10.Users

  @impl true
  def mount(_params, _session, socket) do
    tracks = Tracks.list_tracks()

    {:ok,
      assign(socket, tracks: tracks)
    }
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Mach10Web.Components.Layout.layout selected_menu_item="Tracks">
      <.container class="mt-10">
        <.h2 label="Tracks" />
        <div class="p-1 mt-5 overflow-auto">
          <.table>
            <tbody>
              <%= for track <- @tracks do %>
                <.tr>
                  <.td><a href={"track/#{track.id}"} class="block"><%= track.name %></a></.td>
                </.tr>
              <% end %>
            </tbody>
          </.table>
        </div>
      </.container>
    </Mach10Web.Components.Layout.layout>
    """
  end
end
