defmodule Stipe.Repo do
  use Ecto.Repo,
    otp_app: :stipe,
    adapter: Ecto.Adapters.Postgres
end
