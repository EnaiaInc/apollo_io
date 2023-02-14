defmodule ApolloIo.Person do
  @moduledoc """
  Documentation for `ApolloIo.PeopleEnrichment`.
  """
  alias ApolloIo.{Contact, Employment, Helpers, Organization, PhoneNumber, Request}

  @type t :: %__MODULE__{
          id: String.t(),
          first_name: String.t(),
          last_name: String.t(),
          name: String.t(),
          linkedin_url: String.t(),
          title: String.t(),
          city: String.t(),
          email_status: String.t() | nil,
          photo_url: String.t(),
          twitter_url: String.t() | nil,
          github_url: String.t() | nil,
          facebook_url: String.t() | nil,
          extrapolated_email_confidence: String.t() | nil,
          headline: String.t(),
          country: String.t(),
          email: String.t(),
          state: String.t(),
          excluded_for_leadgen: boolean,
          contact_id: String.t(),
          contact: Contact.t(),
          revealed_for_current_team: boolean,
          organization_id: String.t(),
          organization: Organization.t(),
          phone_numbers: [PhoneNumber.t()],
          employment_history: [Employment.t()]
        }
  defstruct [
    :id,
    :first_name,
    :last_name,
    :name,
    :linkedin_url,
    :title,
    :city,
    :email_status,
    :photo_url,
    :twitter_url,
    :github_url,
    :facebook_url,
    :extrapolated_email_confidence,
    :headline,
    :country,
    :email,
    :state,
    :excluded_for_leadgen,
    :contact_id,
    :contact,
    :revealed_for_current_team,
    :organization_id,
    :organization,
    :phone_numbers,
    :employment_history
  ]

  defmodule BulkPeopleEnrichmentResult do
    @type t :: %__MODULE__{
            status: String.t(),
            error_code: integer() | nil,
            error_message: String.t() | nil,
            total_requested_enrichments: integer(),
            unique_enriched_records: integer(),
            missing_records: integer(),
            credits_consumed: number(),
            matches: [ApolloIo.Person]
          }
    defstruct [
      :status,
      :error_code,
      :error_message,
      :total_requested_enrichments,
      :unique_enriched_records,
      :missing_records,
      :credits_consumed,
      :matches
    ]
  end

  @people_match_url "/people/match"
  @people_bulk_match_url "/people/bulk_match"

  @doc """
  Query the endpoint.
  Accepted values:
  - first_name (optional)
  - last_name (optional)
  - name (optional)
  - email (optional)
  - organization_name (optional)
  - domain (optional)
  - id (optional)
  ref: https://apolloio.github.io/apollo-api-docs/?shell#people-enrichment
  """
  @spec people_enrich(keyword()) :: {:ok, __MODULE__.t()} | {:error, map()}
  def people_enrich(opts) do
    opts = opts |> Enum.into(%{})

    case Request.post(@people_match_url, opts) do
      {:ok, body} ->
        {:ok, cast_to_struct(body["person"])}

      {:error, body} ->
        {:error, body}
    end
  end

  defp cast_to_struct(person_map) do
    Helpers.map_to_struct(person_map, __MODULE__)
    |> Map.update(:contact, nil, &Helpers.map_to_struct(&1, Contact))
    |> Map.update(:organization, nil, &Helpers.map_to_struct(&1, Organization))
    |> Map.update(:employment_history, [], &Helpers.map_list_to_struct(&1, Employment))
    |> Map.update(:phone_numbers, [], &Helpers.map_list_to_struct(&1, PhoneNumber))
  end

  @spec bulk_people_enrich([map()], keyword()) :: {:ok, [__MODULE__.t()]} | {:error, map()}
  def bulk_people_enrich(list_of_details, opts \\ []) do
    opts = opts |> Enum.into(%{})
    opts = Map.put(opts, :details, list_of_details)

    case Request.post(@people_bulk_match_url, opts) do
      {:ok, body} ->
        result =
          body
          |> Helpers.map_to_struct(__MODULE__.BulkPeopleEnrichmentResult)
          |> Map.update(:matches, [], fn matches ->
            Enum.map(matches, &cast_to_struct/1)
          end)

        {:ok, result}

      {:error, body} ->
        {:error, body}
    end
  end
end
