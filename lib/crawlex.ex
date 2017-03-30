defmodule Crawlex do
  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      # Starts a worker by calling: Crawlex.Worker.start_link(arg1, arg2, arg3)
      # worker(Crawlex.Worker, [arg1, arg2, arg3]),
      worker(Crawlex.Supervisor, [])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Crawlex.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
