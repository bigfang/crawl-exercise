defmodule Crawlex.Fetcher do
  @moduledoc """
  Fetcher module of Crawlex.
  """

  require Logger

  @url "http://www.mafengwo.cn/gonglve/ajax.php?act=get_travellist"
  @headers %{"User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.110 Safari/537.36"}

  def fetch(form)do
    case HTTPoison.post(@url, {:form, form}, @headers) do
      {:ok, %{status_code: 200, body: body}} ->
        Logger.info("Page #{Keyword.get(form, :page)}: Fetch SUCCESS!")
        body
      _ ->
        Logger.info("Page #{Keyword.get(form, :page)}: Fetch FAIlED!")
        false
    end
  end
end
