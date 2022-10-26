defmodule Mach10Web.UserLive do
  use Mach10Web, :live_view

  alias Mach10.Records
  alias Mach10.Users

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    user = Users.get_user!(id)
    records = Records.by_user_with_position(id)

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
                <.td><span class="inline-flex items-center rounded-full bg-blue-100 px-3 py-0.5 text-sm font-medium text-blue-800"><%= record.position %></span></.td>
                <.td><%= record.track.name %></.td>
                <.td><%= Timex.Duration.from_milliseconds(record.time_ms) |> Timex.Format.Duration.Formatters.Humanized.format() %></.td>
                <.td><%= record.inserted_at |> Mach10.Cldr.DateTime.to_string!() %></.td>
                <.td>
                  <a href={"/track/#{record.track_id}"} class="block">
                    <button type="button" class="inline-flex items-center rounded-md border border-transparent bg-indigo-600 px-3 py-2 text-sm font-medium leading-4 text-white shadow-sm hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2">Go to track</button>
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
