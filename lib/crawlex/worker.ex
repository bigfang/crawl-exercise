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

  def crawl(arg, f_pid, p_pid, s_pid) do
    body = GenServer.call(f_pid, {:fetch, arg})
    Logger.info("Page #{Keyword.get(arg, :page)}: Parse Starting...")
    list = GenServer.call(p_pid, {:parse, body})
    Logger.info("Page #{Keyword.get(arg, :page)}: Parse #{length(list)} items")
    res = GenServer.call(s_pid, {:store, list})
    Logger.info("Page #{Keyword.get(arg, :page)}: Store #{length(res)} items")
  end

  def work do
    Logger.info("Crawler is Starting!")
    {:ok, f_pid} = GenServer.start_link(Fetcher, nil)
    {:ok, p_pid} = GenServer.start_link(Parser, nil)
    {:ok, s_pid} = GenServer.start_link(Storer, nil)

    init_form = [mddid: 10035, pageid: "mdd_index", sort: 2, cost: 0, days: 0, month: 0, tagid: 0, page: 0]
    forms = for n <- 1..2, do: Keyword.put(init_form, :page, n)
    Enum.map(forms, &crawl(&1, f_pid, p_pid, s_pid))
    Logger.info("Crawler Finished!")
  end

  def handle_call(:run, _from, _state) do
    reply = work()
    {:reply, reply, nil}
  end
end
