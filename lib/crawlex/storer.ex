defmodule Crawlex.Storer do
  @moduledoc """
  Storer module of Crawlex.
  """
  
  use GenServer

  def handle_call({:store, list}, _from, _state) do
    reply = store(list)
    {:reply, reply, nil}
  end

  def store(list) do
      list
      |> Enum.map(fn(url) -> MafwDB.Article.add("http://www.mafengwo.cn" <> url) end)
  end
end
