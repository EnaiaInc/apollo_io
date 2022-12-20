defmodule ApolloIo.Config do
  @moduledoc false

  def base_url do
    if Mix.env() == :test do
      "http://localhost:12345"
    else
      "https://api.apollo.io"
    end
  end
end
