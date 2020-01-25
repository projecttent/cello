defmodule Cello.MixProject do
  use Mix.Project

  def project do
    [
      app: :cello,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:decimal, "~> 1.0"}
    ]
  end

  defp aliases do
    [
      stake: "staker"
    ]
  end
end
