defmodule Mach10Web.SearchResultsLive do
  use Mach10Web, :live_view_search

  alias Mach10.Tracks
  alias Mach10.Users

  @impl true
  def mount(%{"search" => search_term}, _session, socket) do
    send(self(), {:search, search_term})

    {:ok, assign(socket, results: [])}
  end

  @impl true
  def mount(_params_without_search, _session, socket) do
    {:ok, assign(socket, results: [])}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Mach10Web.Components.Layout.layout>
      <div class="grid grid-cols-2 gap-4">
        <div>
          <.h2 label="Users" />
          <.table>
            <tbody>
              <%= for user <- @results[:users] || [] do %>
                <.tr>
                  <.td><a href={"user/#{user.id}"} class="block"><%= user.name %></a></.td>
                </.tr>
              <% end %>
            </tbody>
          </.table>
        </div>
        <div>
          <.h2 label="Tracks" />
          <.table>
            <tbody>
              <%= for track <- @results[:tracks] || [] do %>
                <.tr>
                  <.td><a href={"track/#{track.id}"} class="block"><%= track.name %></a></.td>
                </.tr>
              <% end %>
            </tbody>
          </.table>
        </div>
      </div>
    </Mach10Web.Components.Layout.layout>
    """
  end

  @impl true
  def handle_info({:search, term}, socket) do
    {:noreply,
     socket |> assign(results: %{tracks: Tracks.search(term), users: Users.search(term)})}
  end

  @impl true
  @spec handle_event(<<_::48>>, map, any) :: {:noreply, any}
  def handle_event("search", %{"search" => term}, socket) do
    {:noreply,
     socket
     |> assign(results: %{tracks: Tracks.search(term), users: Users.search(term)}, term: term)}
  end
end
