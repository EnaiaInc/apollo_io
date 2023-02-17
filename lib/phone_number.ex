defmodule ApolloIo.PhoneNumber do
  @type t :: %__MODULE__{
          sanitized_number: String.t(),
          raw_number: String.t(),
          position: integer(),
          type: String.t(),
          dnc_status: String.t(),
          status: String.t()
        }

  @derive Jason.Encoder
  defstruct [
    :sanitized_number,
    :raw_number,
    :position,
    :type,
    :dnc_status,
    :status
  ]
end
