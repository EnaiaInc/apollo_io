defmodule ApolloIo.PostBehaviour do
  @moduledoc """
  Common behaviour for different modules. Used by Mox.
  """

  @callback post_request(binary, binary | map) :: {:ok, map()} | {:error, map()}
end
