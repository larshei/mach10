defmodule Mach10Web.UserLive do
  use Mach10Web, :live_view

  alias Mach10.Records
  alias Mach10.Users

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    user = Users.get_user!(id)
    records = Records.by_user(id)

    Phoenix.PubSub.subscribe(Mach10.PubSub, "record:user:#{id}")

    {:ok,
      assign(socket, records: records, user: user)
    }
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Mach10Web.Components.Layout.layout>
      <div class="p-1 mt-5 overflow-auto">
        <.h2 label={"User: #{@user.name}"} />
        <.table>
          <tbody>
            <%= for record <- @records do %>
              <.tr>
                <.td>
                  <a href={"/track/#{record.track_id}"} class="block">
                    <%= record.track.name %>
                  </a>
                </.td>
                <.td>
                  <a href={"/track/#{record.track_id}"} class="block">
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
    IO.puts "NEW RECORD"
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
