defmodule ApolloIo do
  @moduledoc """
  Documentation for `ApolloIo`.
  """

  @doc """
  This endpoint enriches a person's information, the more information you pass in, the more likely we can find a match.

  The enrich endpoint charges you credits for its usage. If a verified email is successfully returned, it will cost you 1 credit. If an email is not found, but Apollo successfully found ALL of the following information: Name, Linkedin Profile, Current Company Information, Apollo will charge a fraction of a credit. Typically this is 0.01 credit per successful enrichment without email. But it may be higher depending on your specific plan.

  The enrich endpoint charges credits even if the person is already in your CRM. The enrich endpoint also charges credits if you pass in the same information multiple times.

  ## Examples
      iex> ApolloIo.people_enrich([first_name: "James", last_name: "Cameroon"])
  """
  defdelegate people_enrich(opts), to: ApolloIo.Person

  @doc """
  This endpoint enriches people information in bulk - the more information you pass in, the more likely we can find a match.

  Up to 10 records can be enriched at the same time through this endpoint.

  ### Credit Usage
  The enrich endpoint charges you credits for its usage. If a verified email is successfully returned or the list of personal emails is revealed, it will cost you 1 credit. If an email is not found, but Apollo successfully found ALL of the following information: Name, Linkedin Profile, Current Company Information, Apollo will charge a fraction of a credit. Typically this is 0.01 credit per successful enrichment without email. But it may be higher depending on your specific plan.

  Duplicate enrichments of the same record will not be charged credits.

  ### Rate Limits
  Rate limits on this endpoint are 1/10th of what is available on the single enrichment endpoint.

  ## Examples
      iex> ApolloIo.bulk_people_enrich([%{first_name: "James", last_name: "Cameroon"}])
  """
  defdelegate bulk_people_enrich(list_of_details, opts \\ []), to: ApolloIo.Person

  @doc """
  This endpoint enriches a company with info such as industry, company size, etc. based on the domain parameter passed in.

  ## Examples
      iex> ApolloIo.organization_enrich(domain: "patagonia.com")
  """
  defdelegate organization_enrich(opts), to: ApolloIo.Organization

  @doc """
  This endpoint searches for people. Calls to the search endpoint do not cost you credits. They also do not return any email information. To get email information, use the "enrich" endpoint.
  This function support pagination by passing `page: page_number` to the list of parameters.

  ## Examples
      iex> ApolloIo.search([person_titles: ["sales director", "engineer manager"], q_organization_domains: "google.com\nfacebook.com", page: 1])
  """
  defdelegate search(opts), to: ApolloIo.Search
end
