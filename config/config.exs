# config :apollo_io, organization_client: ApolloIo.OrganizationEnrichmentMock

import Config

organization_client =
  if Mix.env() == :test do
    ApolloIo.OrganizationEnrichmentMock
  else
    ApolloIo.OrganizationEnrichment
  end
people_client =
  if Mix.env() == :test do
    ApolloIo.PeopleEnrichmentMock
  else
    ApolloIo.PeopleEnrichment
  end
search_client =
  if Mix.env() == :test do
    ApolloIo.SearchMock
  else
    ApolloIo.Search
  end

config :apollo_io, apollo_io_api_key: System.get_env("APOLLO_IO_API_KEY")
config :apollo_io, organization_client: organization_client
config :apollo_io, people_client: people_client
config :apollo_io, search_client: search_client
