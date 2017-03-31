defmodule Crawlex.Storer do
  @moduledoc """
  Storer module of Crawlex.
  """

  use GenServer

  def start_link do
    {:ok, pid} = GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def store(term) do
    GenServer.call(__MODULE__, {:store, term})
  end

  def handle_call({:store, list}, _from, _state) do
    res = list
          |> Enum.map(fn(url) -> MafwDB.Article.add("http://www.mafengwo.cn" <> url) end)
    {:reply, res, nil}
  end
end
