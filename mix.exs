defmodule ChatElixir.MixProject do
  use Mix.Project

  def project do
    [
      app: :chat_elixir,
      version: get_version_number(),
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :sqlitex, :plug_cowboy, :email_checker],
      mod: {ChatElixir.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:email_checker, "~> 0.1.2"},
      {:jason, "~> 1.1.2"},
      {:plug, "~> 1.0"},
      {:plug_cowboy, "~> 2.0"},
      {:sqlitex, "~> 1.4.2"}
    ]
  end

  # Get version number based on git commit
  #
  defp get_version_number do
    commit = 
      :os.cmd('git rev-parse --short HEAD') 
      |> to_string 
      |> String.trim_trailing("\n")

    v = "0.1.0+#{commit}"

    case Mix.env() do
      :dev -> v <> "dev"
      _ -> v
    end
  end
end
