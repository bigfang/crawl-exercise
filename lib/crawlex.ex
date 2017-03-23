defmodule Crawlex do
  @moduledoc """
  Documentation for Crawlex.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Crawlex.hello
      :world

  """
  alias Crawlex.{Fetcher, Parser}

  def run do
    Fetcher.fetch
    |> Parser.parse
    |> IO.inspect

    nil
  end
end
