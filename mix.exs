defmodule Crawlex.Mixfile do
  use Mix.Project

  def project do
    [app: :crawlex,
     version: "0.0.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     name: "Crawler-exercise",
     docs: [main: "readme",
            extras: ["README.md"]]]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger],
     registered: [:crawlex],
     mod: {Crawlex, []}]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [{:httpoison, "~> 0.11.0"},
     {:poison, "~> 3.0"},
     {:floki, "~> 0.15.0"},
     {:amnesia, "~> 0.2.7"},
     {:ex_doc, "~> 0.15", only: :dev, runtime: false}]
  end
end
