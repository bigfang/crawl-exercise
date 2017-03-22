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
  alias Crawlex.Fetcher

  def run do
    Fetcher.fetch
  end
end
