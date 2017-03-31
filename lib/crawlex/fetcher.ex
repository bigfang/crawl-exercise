defmodule Crawlex.Fetcher do
  @moduledoc """
  Fetcher module of Crawlex.
  """

  use GenServer

  require Logger

  @url "http://www.mafengwo.cn/gonglve/ajax.php?act=get_travellist"
  @headers %{"User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.110 Safari/537.36"}

  def start_link do
    {:ok, pid} = GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def fetch(term) do
    GenServer.call(__MODULE__, {:fetch, term})
  end

  def handle_call({:fetch, form}, _from, _state) do
    case HTTPoison.post(@url, {:form, form}, @headers) do
      {:ok, %{status_code: 200, body: body}} ->
        Logger.info("Page #{Keyword.get(form, :page)}: Fetch SUCCESS!")
        {:reply, body, nil}
      _ ->
        Logger.info("Page #{Keyword.get(form, :page)}: Fetch FAIlED!")
        {:noreply, nil}
    end
  end
end
