defmodule ApolloIo do
  @moduledoc """
  Documentation for `ApolloIo`.
  """

  @doc """
  This endpoint enriches a person's information, the more information you pass in, the more likely we can find a match.

  The enrich endpoint charges you credits for its usage. If a verified email is successfully returned, it will cost you 1 credit. If an email is not found, but Apollo successfully found ALL of the following information: Name, Linkedin Profile, Current Company Information, Apollo will charge a fraction of a credit. Typically this is 0.01 credit per successful enrichment without email. But it may be higher depending on your specific plan.

  The enrich endpoint charges credits even if the person is already in your CRM. The enrich endpoint also charges credits if you pass in the same information multiple times.

  usage:
  ApolloIo.people_enrich(%{first_name: "James", last_name: "Cameroon"}) ==
  """
  defdelegate people_enrich(opts), to: ApolloIo.PeopleEnrichment

  @doc """
  This endpoint enriches a company with info such as industry, company size, etc. based on the domain parameter passed in.

  usage:
  ApolloIo.organization_enrich("patagonia.com") ==
  """
  defdelegate organization_enrich(domain), to: ApolloIo.OrganizationEnrichment

  @doc """
  This endpoint searches for people. Calls to the search endpoint do not cost you credits. They also do not return any email information. To get email information, use the "enrich" endpoint.

  usage:
  ApolloIo.search(%{
               person_titles: ["sales director", "engineer manager"],
               q_organization_domains: "google.com\nfacebook.com",
               page: 1
             })
  """
  defdelegate search(opts), to: ApolloIo.Search
end
