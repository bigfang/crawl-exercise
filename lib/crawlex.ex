defmodule Crawlex do
  @moduledoc """
  Documentation for Crawlex.
  """

  require Logger
  alias Crawlex.{Fetcher, Parser, Storer}

  def crawl(arg) do
    arg
    |> Fetcher.fetch
    |> (fn(x) -> Logger.info("Page #{Keyword.get(arg, :page)}: Parse Starting..."); x end).()
    |> Parser.parse
    |> (fn(x) -> Logger.info("Page #{Keyword.get(arg, :page)}: Parse #{length(x)} items"); x end).()
    |> Storer.store
    |> (fn(x) -> Logger.info("Page #{Keyword.get(arg, :page)}: Store #{length(x)} items") end).()
  end

  def crawl(arg, f_pid, p_pid, s_pid) do
    body = GenServer.call(f_pid, {:fetch, arg})
    Logger.info("Page #{Keyword.get(arg, :page)}: Parse Starting...")
    list = GenServer.call(p_pid, {:parse, body})
    Logger.info("Page #{Keyword.get(arg, :page)}: Parse #{length(list)} items")
    res = GenServer.call(s_pid, {:store, list})
    Logger.info("Page #{Keyword.get(arg, :page)}: Store #{length(res)} items")
  end

  def run do
    Logger.info("Crawler is Starting!")
    {:ok, f_pid} = GenServer.start_link(Crawlex.Fetcher, nil)
    {:ok, p_pid} = GenServer.start_link(Crawlex.Parser, nil)
    {:ok, s_pid} = GenServer.start_link(Crawlex.Storer, nil)

    init_form = [mddid: 10035, pageid: "mdd_index", sort: 2, cost: 0, days: 0, month: 0, tagid: 0, page: 0]
    forms = for n <- 1..2, do: Keyword.put(init_form, :page, n)
    Enum.map(forms, &crawl(&1, f_pid, p_pid, s_pid))
    Logger.info("Crawler Finished!")
  end
end
