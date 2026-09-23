defmodule SetLocale.Mixfile do
  use Mix.Project

  def project do
    [
      app: :set_locale,
      version: "0.4.6",
      description:
        "A Phoenix Plug to help with supporting I18n routes (http://www.example.org/de-at/foo/bar/az). Will also set Gettext to the requested locale used in the url when supported by your Gettext.",
      package: package(),
      elixir: "~> 1.7",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:phoenix, ">1.3.0"},
      {:plug, "~> 1.8"},
      {:gettext, "~> 0.14 or ~> 1.0"},
      {:ex_doc, "~> 0.40", only: :dev, runtime: false}
    ]
  end

  defp package do
    [
      licenses: ["WTFPL"],
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      links: %{"GitHub" => "https://github.com/jackjoe/set_locale"}
    ]
  end
end
