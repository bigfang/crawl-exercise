defmodule Crawlex.Fetcher do
  @moduledoc """
  Documentation for Crawlex.
  """

  @url "http://www.mafengwo.cn/gonglve/ajax.php?act=get_travellist"
  @headers %{"User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.110 Safari/537.36"}

  def fetch do
    form = [mddid: 10035, pageid: "mdd_index", sort: 2, cost: 0, days: 0, month: 0, tagid: 0, page: 1]
    case HTTPoison.post(@url, {:form, form}, @headers) do
      {:ok, %{status_code: 200, body: body}} ->
        body
      _ ->
        false
    end
  end
end
