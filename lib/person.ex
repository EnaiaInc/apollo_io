defmodule ApolloIo.Person do
  @moduledoc """
  Documentation for `ApolloIo.PeopleEnrichment`.
  """
  alias ApolloIo.{Contact, Helpers, Organization, Request}

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
          organization: Organization.t()
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
    :organization
  ]

  @people_match_url "/people/match"

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
        {:ok, cast_to_struct(body)}

      {:error, body} ->
        {:error, body}
    end
  end

  defp cast_to_struct(body) do
    Helpers.map_to_struct(body["person"], __MODULE__)
    |> Map.update(:contact, nil, &Helpers.map_to_struct(&1, Contact))
    |> Map.update(:organization, nil, &Helpers.map_to_struct(&1, Organization))
  end
end
