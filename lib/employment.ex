defmodule ApolloIo.Employment do
  @moduledoc """
  Employment struct for use in employment_history of bulk_people_enrich
  """
  @type t :: %__MODULE__{
          id: String.t(),
          organization_id: String.t(),
          organization_name: String.t(),
          title: String.t(),
          current: boolean(),
          start_date: Date.t(),
          end_date: Date.t(),
          degree: String.t(),
          description: String.t(),
          emails: list(),
          grade_level: String.t(),
          key: String.t(),
          kind: String.t(),
          major: String.t(),
          raw_address: String.t(),
          created_at: DateTime.t(),
          updated_at: DateTime.t()
        }
  @derive Jason.Encoder
  use ApolloIo.Accessible

  defstruct [
    :id,
    :organization_id,
    :organization_name,
    :title,
    :current,
    :start_date,
    :end_date,
    :degree,
    :description,
    :emails,
    :grade_level,
    :key,
    :kind,
    :major,
    :raw_address,
    :created_at,
    :updated_at
  ]
end
