defmodule Mach10Web.Components.Layout do
  use Mach10Web, :live_view

  attr :menu_items, :list, default: [
    %{name: "Home", path: "/"},
    %{name: "Users", path: "/users"},
    %{name: "Tracks", path: "/tracks"},
  ]
  attr :selected_menu_item, :string, default: "Dashboard"

  def layout(assigns) do
    ~H"""
    <!--
      This example requires some changes to your config:

      ```
      // tailwind.config.js
      module.exports = {
        // ...
        plugins: [
          // ...
          require('@tailwindcss/forms'),
        ],
      }
      ```
    -->
    <!--
      This example requires updating your template:

      ```
      <html class="h-full bg-gray-100">
      <body class="h-full">
      ```
    -->
      <div>
    <!-- Off-canvas menu for mobile, show/hide based on off-canvas menu state. -->
      <div class="relative z-40 md:hidden" role="dialog" aria-modal="true">
        <!--
          Off-canvas menu backdrop, show/hide based on off-canvas menu state.

          Entering: "transition-opacity ease-linear duration-300"
            From: "opacity-0"
            To: "opacity-100"
          Leaving: "transition-opacity ease-linear duration-300"
            From: "opacity-100"
            To: "opacity-0"
        -->
        <div class="fixed inset-0 bg-gray-600 bg-opacity-75"></div>

        <div class="fixed inset-0 z-40 flex">
          <!--
            Off-canvas menu, show/hide based on off-canvas menu state.

            Entering: "transition ease-in-out duration-300 transform"
              From: "-translate-x-full"
              To: "translate-x-0"
            Leaving: "transition ease-in-out duration-300 transform"
              From: "translate-x-0"
              To: "-translate-x-full"
          -->
          <div class="relative flex w-full max-w-xs flex-1 flex-col bg-indigo-700 pt-5 pb-4">
            <!--
              Close button, show/hide based on off-canvas menu state.

              Entering: "ease-in-out duration-300"
                From: "opacity-0"
                To: "opacity-100"
              Leaving: "ease-in-out duration-300"
                From: "opacity-100"
                To: "opacity-0"
            -->
            <div class="absolute top-0 right-0 -mr-12 pt-2">
              <button type="button" class="ml-1 flex h-10 w-10 items-center justify-center rounded-full focus:outline-none focus:ring-2 focus:ring-inset focus:ring-white">
                <span class="sr-only">Close sidebar</span>
                <Mach10Web.Components.HeroIcons.x_mark />
              </button>
            </div>

            <div class="flex flex-shrink-0 items-center px-4">
              <img class="h-8 w-auto" src="https://tailwindui.com/img/logos/mark.svg?color=indigo&shade=300" alt="Your Company">
            </div>
            <div class="mt-5 h-0 flex-1 overflow-y-auto">
              <nav class="space-y-1 px-2">

              </nav>
            </div>
          </div>

          <div class="w-14 flex-shrink-0" aria-hidden="true">
            <!-- Dummy element to force sidebar to shrink to fit close icon -->
          </div>
        </div>
      </div>

      <!-- Static sidebar for desktop -->
      <div class="hidden md:fixed md:inset-y-0 md:flex md:w-64 md:flex-col">
        <!-- Sidebar component, swap this element with another sidebar if you like -->
        <div class="flex flex-grow flex-col overflow-y-auto bg-indigo-700 pt-5">
          <div class="flex flex-shrink-0 items-center px-4">
            <img class="h-8 w-auto" src="https://tailwindui.com/img/logos/mark.svg?color=indigo&shade=300" alt="Your Company">
          </div>
          <div class="mt-5 flex flex-1 flex-col">
            <nav class="flex-1 space-y-1 px-2 pb-4">
              <!-- Current: "bg-indigo-800 text-white", Default: "text-indigo-100 hover:bg-indigo-600" -->
              <%= for item <- @menu_items do %>
                <.menu_item name={item.name} selected_menu_item={@selected_menu_item} path={item.path} />
              <% end %>
            </nav>
          </div>
        </div>
      </div>
      <div class="flex flex-1 flex-col md:pl-64">
        <div class="sticky top-0 z-10 flex h-16 flex-shrink-0 bg-white shadow">
          <button type="button" class="border-r border-gray-200 px-4 text-gray-500 focus:outline-none focus:ring-2 focus:ring-inset focus:ring-indigo-500 md:hidden">
            <span class="sr-only">Open sidebar</span>
            <Mach10Web.Components.HeroIcons.bars_3_bottom_left />
          </button>
          <div class="flex flex-1 justify-between px-4">
            <div class="flex flex-1">
              <form class="flex w-full md:ml-0" action="#" method="GET">
                <label for="search-field" class="sr-only">Search</label>
                <div class="relative w-full text-gray-400 focus-within:text-gray-600">
                  <div class="pointer-events-none absolute inset-y-0 left-0 flex items-center">
                    <Mach10Web.Components.HeroIcons.magnifying_glass />
                  </div>
                  <input id="search-field" class="block h-full w-full border-transparent py-2 pl-8 pr-3 text-gray-900 placeholder-gray-500 focus:border-transparent focus:placeholder-gray-400 focus:outline-none focus:ring-0 sm:text-sm" placeholder="Search" type="search" name="search">
                </div>
              </form>
            </div>
          </div>
        </div>
        <main>
          <.container class="mt-10">
            <%= render_slot(@inner_block) %>
          </.container>
        </main>
      </div>
    </div>
    """
  end

  attr :name, :string, required: true
  attr :path, :string, required: true
  attr :selected_menu_item, :string, required: true
  def menu_item(assigns) do
    ~H"""
      <!-- Current: "bg-indigo-800 text-white", Default: "text-indigo-100 hover:bg-indigo-600" -->
      <a href={@path} class={"#{menu_item_styling(@name, @selected_menu_item)} group flex items-center px-2 py-2 text-base font-medium rounded-md"}>
        <%= @name %>
      </a>
    """
  end

  defp menu_item_styling(name, selected) when name == selected, do: "bg-indigo-800 text-white"
  defp menu_item_styling(_, _), do: "text-indigo-100 hover:bg-indigo-600"
end
