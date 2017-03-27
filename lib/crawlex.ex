defmodule Crawlex do
  @moduledoc """
  Documentation for Crawlex.
  """

  alias Crawlex.{Fetcher, Parser, Storer}

  def work(arg) do
    Fetcher.fetch(arg)
    |> Parser.parse
    |> Storer.store
    |> IO.inspect
  end

  def run do
    init_form = [mddid: 10035, pageid: "mdd_index", sort: 2, cost: 0, days: 0, month: 0, tagid: 0, page: 0]
    forms = for n <- 1..3, do: Keyword.put(init_form, :page, n)
    Enum.map(forms, &work/1)
  end
end
