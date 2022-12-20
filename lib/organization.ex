defmodule ApolloIo.Organization do
  alias ApolloIo.{Account, Helpers, Request}

  @type t :: %__MODULE__{
          id: String.t(),
          name: String.t(),
          website_url: String.t(),
          blog_url: String.t() | nil,
          angellist_url: String.t() | nil,
          linkedin_url: String.t() | nil,
          twitter_url: String.t() | nil,
          facebook_url: String.t() | nil,
          languages: list,
          alexa_ranking: number,
          phone: String.t() | nil,
          linkedin_uid: integer,
          publicly_traded_symbol: String.t() | nil,
          publicly_traded_exchange: String.t() | nil,
          logo_url: String.t(),
          crunchbase_url: String.t() | nil,
          primary_domain: String.t(),
          persona_counts: map,
          industry: String.t(),
          keywords: list,
          estimated_num_employees: integer,
          snippets_loaded: boolean,
          industry_tag_id: String.t(),
          retail_location_count: integer,
          raw_address: String.t(),
          street_address: String.t(),
          city: String.t(),
          state: String.t(),
          postal_code: String.t(),
          country: String.t(),
          owned_by_organization_id: String.t() | nil,
          suborganizations: list,
          num_suborganizations: integer,
          seo_description: String.t(),
          short_description: String.t(),
          total_funding: number | nil,
          total_funding_printed: number | nil,
          latest_funding_round_date: Date.t() | nil,
          latest_funding_stage: String.t() | nil,
          funding_events: list,
          technology_names: list,
          current_technologies: list,
          account_id: String.t(),
          account: Account.t()
        }
  defstruct [
    :id,
    :name,
    :website_url,
    :blog_url,
    :angellist_url,
    :linkedin_url,
    :twitter_url,
    :facebook_url,
    :languages,
    :alexa_ranking,
    :phone,
    :linkedin_uid,
    :publicly_traded_symbol,
    :publicly_traded_exchange,
    :logo_url,
    :crunchbase_url,
    :primary_domain,
    :persona_counts,
    :industry,
    :keywords,
    :estimated_num_employees,
    :snippets_loaded,
    :industry_tag_id,
    :retail_location_count,
    :raw_address,
    :street_address,
    :city,
    :state,
    :postal_code,
    :country,
    :owned_by_organization_id,
    :suborganizations,
    :num_suborganizations,
    :seo_description,
    :short_description,
    :total_funding,
    :total_funding_printed,
    :latest_funding_round_date,
    :latest_funding_stage,
    :funding_events,
    :technology_names,
    :current_technologies,
    :account_id,
    :account
  ]

  @organization_match_url "/organizations/enrich"

  @doc """
  Query the endpoint.
  Required parameter is passed as a string.
  - domain
  ref: https://apolloio.github.io/apollo-api-docs/?shell#organization-enrichment
  """
  @spec organization_enrich(String.t()) :: {:ok, __MODULE__.t()} | {:error, map()}
  def organization_enrich(domain) do
    opts = %{domain: domain}

    case Request.get(@organization_match_url, opts) do
      {:ok, body} ->
        {:ok, cast_to_struct(body)}

      {:error, body} ->
        {:error, body}
    end
  end

  defp cast_to_struct(body) do
    Helpers.map_to_struct(body["organization"], __MODULE__)
    |> Map.update(:account, nil, &Helpers.map_to_struct(&1, Account))
  end
end
