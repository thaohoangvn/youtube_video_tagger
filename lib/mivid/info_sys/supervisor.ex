defmodule Mivid.InfoSys.Supervisor do
  use Supervisor

  def start_link() do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(opts) do
    children = [
      worker(Mivid.InfoSys, [], restart: :temporary)
    ]
    supervise children, strategy: :simple_one_for_one
  end
end
