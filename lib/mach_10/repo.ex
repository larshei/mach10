defmodule Mach10.Repo do
  use Ecto.Repo,
    otp_app: :mach_10,
    adapter: Ecto.Adapters.Postgres
end
