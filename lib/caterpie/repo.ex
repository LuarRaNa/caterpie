defmodule Caterpie.Repo do
  use Ecto.Repo,
    otp_app: :caterpie,
    adapter: Ecto.Adapters.Postgres
end
