defmodule Crawlex do
  @moduledoc """
  Documentation for Crawlex.
  """

  alias Crawlex.{Fetcher, Parser}

  def run do
    Fetcher.fetch
    |> Parser.parse
    |> IO.inspect

    nil
  end
end
