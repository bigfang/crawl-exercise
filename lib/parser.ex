defmodule Crawlex.Parser do
  @moduledoc """
  Parser module of Crawlex.
  """

  def parse(body) do
    {:ok, %{"list" => html}} = Poison.decode(body)
    html
    |> Floki.find(".tn-item .tn-image a")
    |> Floki.attribute("href")
    |> Enum.map(fn(url) -> MafwDB.Article.add("http://www.mafengwo.cn" <> url) end)
  end
end
