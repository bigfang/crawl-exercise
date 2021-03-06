defmodule Crawlex.Parser do
  @moduledoc """
  Parser module of Crawlex.
  """

  use GenServer

  def start_link do
    {:ok, _pid} = GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def parse(term) do
    GenServer.call(__MODULE__, {:parse, term})
  end

  def handle_call({:parse, body}, _from, _state) do
    {:ok, %{"list" => html}} = Poison.decode(body)
    html
    |> Floki.find(".tn-item .tn-image a")
    |> Floki.attribute("href")
    |> (&({:reply, &1, nil})).()
  end
end
