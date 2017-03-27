defmodule Crawlex.Storer do
  @moduledoc """
  Storer module of Crawlex.
  """

  def store(list) do
      list
      |> Enum.map(fn(url) -> MafwDB.Article.add("http://www.mafengwo.cn" <> url) end)
  end
end
