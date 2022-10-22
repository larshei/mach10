defmodule Mach10Web.TrackLive do
  use Mach10Web, :live_view

  alias Mach10.Records
  alias Mach10.Tracks

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    track = Tracks.get_track!(id)
    records = Records.by_track(id)

    Phoenix.PubSub.subscribe(Mach10.PubSub, "record:track:#{id}")

    {:ok,
      assign(socket, records: records, track: track)
    }
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Mach10Web.Components.Layout.layout>
      <div class="p-1 mt-5 overflow-auto">
        <.h2 label={"Track: #{@track.name}"} />
        <.table>
          <tbody>
            <%= for record <- @records do %>
              <.tr>
                <.td>
                  <a href={"/user/#{record.user_id}"} class="block">
                    <%= record.user.name %>
                  </a>
                </.td>
                <.td>
                  <a href={"/user/#{record.user_id}"} class="block">
                    <%= Timex.Duration.from_milliseconds(record.time_ms) |> Timex.Format.Duration.Formatters.Humanized.format() %>
                  </a>
                </.td>
                <.td>
                  <a href={"/track/#{record.track_id}"} class="block">
                    <%= record.inserted_at |> Mach10.Cldr.DateTime.to_string!() %>
                  </a>
                </.td>
              </.tr>
            <% end %>
          </tbody>
        </.table>
      </div>
    </Mach10Web.Components.Layout.layout>
    """
  end

  @impl true
  def handle_info({:record, :inserted, record}, socket) do
    records = [record | socket.assigns.records]
    |> Enum.sort_by(& &1.time_ms)

    {:noreply, socket |> assign(records: records)}
  end

  @impl true
  def handle_info({:record, :updated, record}, socket) do
    records = socket.assigns.records
    |> Enum.map(fn %{id: id} = previous ->
      case id == record do
        true -> record
        false -> previous
      end
    end)
    |> Enum.sort_by(& &1.time_ms)

    {:noreply, socket |> assign(records: records)}
  end

  @impl true
  def handle_info({:record, :deleted, record}, socket) do
    records = socket.assigns.records
    |> Enum.filter(& &1.id != record.id)

    {:noreply, socket |> assign(records: records)}
  end
end
