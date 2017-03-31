defmodule Crawlex.Storer do
  @moduledoc """
  Storer module of Crawlex.
  """

  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def store(term) do
    GenServer.call(__MODULE__, {:store, term})
  end

  def handle_call({:store, list}, _from, _state) do
    list
    |> Enum.map(fn(url) -> MafwDB.Article.add("http://www.mafengwo.cn" <> url) end)
    |> (&({:reply, &1, nil})).()
  end
end
