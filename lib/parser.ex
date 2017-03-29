defmodule Crawlex.Parser do
  @moduledoc """
  Parser module of Crawlex.
  """
  use GenServer

  def handle_call({:parse, body}, _from, _state) do
    reply = parse(body)
    {:reply, reply, nil}
  end

  def parse(body) do
    {:ok, %{"list" => html}} = Poison.decode(body)
    html
    |> Floki.find(".tn-item .tn-image a")
    |> Floki.attribute("href")
  end
end
