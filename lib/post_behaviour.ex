defmodule ApolloIo.PostBehaviour do
  @moduledoc """
  Common behaviour for different modules. Used by Mox.
  """

  @callback post_request(binary | map) :: {:ok, map()} | {:error, map()}
end
