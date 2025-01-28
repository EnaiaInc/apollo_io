defmodule ApolloIo.Error do
  @type t :: %__MODULE__{message: String.t()}
  @derive Jason.Encoder
  @derive JSON.Encoder
  use ApolloIo.Accessible
  defstruct [:message]
end
