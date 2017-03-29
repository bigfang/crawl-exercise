defmodule Crawlex do
  @moduledoc """
  Documentation for Crawlex.
  """

  require Logger
  alias Crawlex.{Fetcher, Parser, Storer}

  def work(arg) do
    Fetcher.fetch(arg)
    |> (fn(x) -> Logger.info("Page #{Keyword.get(arg, :page)}: Parse Starting..."); x end).()
    |> Parser.parse
    |> (fn(x) -> Logger.info("Page #{Keyword.get(arg, :page)}: Parse #{length(x)} items"); x end).()
    |> Storer.store
    |> (fn(x) -> Logger.info("Page #{Keyword.get(arg, :page)}: Store #{length(x)} items") end).()
  end

  def run do
    Logger.info("Crawler is Starting!")
    init_form = [mddid: 10035, pageid: "mdd_index", sort: 2, cost: 0, days: 0, month: 0, tagid: 0, page: 0]
    forms = for n <- 1..2, do: Keyword.put(init_form, :page, n)
    Enum.map(forms, &work/1)
    Logger.info("Crawler Finished!")
  end
end
