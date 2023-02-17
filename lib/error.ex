defmodule ApolloIo.Error do
  @type t :: %__MODULE__{message: String.t()}
  @derive Jason.Encoder
  defstruct [:message]
end
