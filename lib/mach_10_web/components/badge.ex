defmodule Mach10Web.Components.Badge do
  use Phoenix.Component

  attr :color, :string, default: "purple"
  def badge(assigns) do
    ~H"""
    <span class={"inline-flex items-center rounded-full bg-#{@color}-100 px-2.5 py-0.5 text-xs font-medium text-#{@color}-800"}>
      <%= render_slot(@inner_block) %>
    </span>
    """
  end
end
