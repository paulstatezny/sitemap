defmodule ExSitemapGenerator.Location do
  alias ExSitemapGenerator.Namer
  alias ExSitemapGenerator.Adapter.File, as: FileAdapter

  defstruct [
    adapter: FileAdapter,
    public_path: "",
    filename: "sitemap",
    sitemaps_path: "sitemaps/",
    host: "http://www.example.com",
    namer: Namer,
    verbose: true,
    compress: true,
    create_index: :auto
  ]

  def start_link(name) do
    Agent.start_link(fn -> %__MODULE__{} end, name: namepid(name))
  end

  def state(name) do
    Agent.get(namepid(name), &(&1))
  end

  defp namepid(name) do
    String.to_atom(Enum.join([__MODULE__, name]))
  end

  def write(name, data) do
    s =
      name
      |> namepid
      |> state

    s.adapter.write(data)
  end

end