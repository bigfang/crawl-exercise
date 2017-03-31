defmodule Crawlex.Worker do
  @moduledoc """
  Documentation for Crawlex.
  """

  use GenServer

  require Logger
  alias Crawlex.{Fetcher, Parser, Storer}

  def start_link do
    {:ok, _pid} = GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def run do
    GenServer.call(__MODULE__, :run)
  end

  def handle_call(:run, _from, _state) do
    reply = work()
    {:reply, reply, nil}
  end

  def crawl(arg) do
    arg
    |> Fetcher.fetch
    |> (fn(x) -> Logger.info("Page #{Keyword.get(arg, :page)}: Parse Starting..."); x end).()
    |> Parser.parse
    |> (fn(x) -> Logger.info("Page #{Keyword.get(arg, :page)}: Parse #{length(x)} items"); x end).()
    |> Storer.store
    |> (fn(x) -> Logger.info("Page #{Keyword.get(arg, :page)}: Store #{length(x)} items") end).()
  end

  def work do
    Logger.info("Crawler is Starting!")
    Fetcher.start_link
    Parser.start_link
    Storer.start_link

    init_form = [mddid: 10035, pageid: "mdd_index", sort: 2, cost: 0, days: 0, month: 0, tagid: 0, page: 0]
    forms = for n <- 1..2, do: Keyword.put(init_form, :page, n)
    Enum.map(forms, &crawl/1)
    Logger.info("Crawler Finished!")
  end
end
