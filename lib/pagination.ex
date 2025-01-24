defmodule ApolloIo.Pagination do
  alias ApolloIo.Helpers

  @type t :: %__MODULE__{
          page: non_neg_integer,
          per_page: non_neg_integer,
          total_entries: non_neg_integer,
          total_pages: non_neg_integer
        }

  @derive Jason.Encoder
  @derive JSON.Encoder
  use ApolloIo.Accessible

  defstruct [
    :page,
    :per_page,
    :total_entries,
    :total_pages
  ]

  def cast_to_struct(data) do
    Helpers.map_to_struct(data, __MODULE__)
  end
end
