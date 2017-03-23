defmodule Crawlex.Parser do
  def parse(body) do
    {:ok, %{"list" => html}} = Poison.decode(body)
    html
    |> Floki.find(".tn-item .tn-image a")
    |> Floki.attribute("href")
    |> Enum.map(fn(url) -> "http://www.mafengwo.cn" <> url end)
    |> Enum.into([])
    |> Enum.map(fn(url) -> MafwDB.Article.add(url) end)
  end
end
