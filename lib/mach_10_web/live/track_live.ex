defmodule Mach10Web.TrackLive do
  use Mach10Web, :live_view

  alias Mach10.Records

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    records = Records.by_track(id)

    {:ok,
      assign(socket, records: records)
    }
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Mach10Web.Components.Layout.layout>
      <div class="p-1 mt-5 overflow-auto">
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
              </.tr>
            <% end %>
          </tbody>
        </.table>
      </div>
    </Mach10Web.Components.Layout.layout>
    """
  end
end
