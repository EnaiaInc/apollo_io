defmodule ApolloIo.MixProject do
  use Mix.Project

  def project do
    [
      app: :apollo_io,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :confex]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:confex, "~> 3.5"},
      {:dotenv, "~> 3.1"},
      {:mox, "~> 1.0"},
      {:req, "~> 0.3.3"}
    ]
  end
end
