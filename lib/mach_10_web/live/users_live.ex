defmodule Mach10Web.UsersLive do
  use Mach10Web, :live_view

  alias Mach10.Users

  @impl true
  def mount(_params, _session, socket) do
    users = Users.list_users()

    {:ok,
      assign(socket, users: users)
    }
  end

  @impl true
  def render(assigns) do
    ~H"""
    <Mach10Web.Components.Layout.layout selected_menu_item="Users">
      <.container class="mt-10">
        <.h2 label="Users" />
        <div class="p-1 mt-5 overflow-auto">
          <.table>
            <tbody>
              <%= for user <- @users do %>
                <.tr>
                  <.td><a href={"user/#{user.id}"} class="block"><%= user.name %></a></.td>
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
