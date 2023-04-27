defmodule ApolloIo.RateLimit do
  @moduledoc """
  Struct containing API usage information.
  """
  @type t :: %__MODULE__{minute: map, hourly: map, daily: map}
  @derive Jason.Encoder
  defstruct [:minute, :hourly, :daily]

  @doc """
  Creates a new %RateLimit{} with the provided attributes.
  """
  def new, do: struct(__MODULE__)
  def new(opts), do: struct(__MODULE__, opts)
end
