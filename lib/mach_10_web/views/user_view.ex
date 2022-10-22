defmodule Mach10Web.UserView do
  use Mach10Web, :view
  alias Mach10Web.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      deleted_at: user.deleted_at,
      id: user.id,
      image_url: user.image_url,
      inserted_at: user.inserted_at,
      last_seen_at: user.last_seen_at,
      name: user.name,
      updated_at: user.updated_at,
    }
  end
end
