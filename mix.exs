defmodule Layers.Mixfile do
  use Mix.Project

  def project do
    [app: :layers,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [applications: [:logger
                    #, :csvlixir, :sfmt
                   ],
     mod: {Layers, []}]
  end

  defp deps do
    [
      {:csvlixir, "~> 2.0"},
      {:matrex, "~> 0.6"},
      # TODO Remove  
      {:sfmt, git: "https://github.com/jj1bdx/sfmt-erlang.git"}
    ]
  end
end
