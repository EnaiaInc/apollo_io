defmodule ApolloIo.OrganizationEnrichment do
  @moduledoc """
  Documentation for `ApolloIo.OrganizationEnrichment`.
  """
  alias ApolloIo.PostBehaviour

  @organization_match_url "/organizations/enrich"
  @service Confex.get_env(:apollo_io, :organization_client)

  @doc """
  Query the endpoint.
  Required parameter is passed as a string.
  - domain
  ref: https://apolloio.github.io/apollo-api-docs/?shell#organization-enrichment
  """
  def organization_enrich(domain), do: @service.post_request(domain)

  @behaviour PostBehaviour
  def post_request(domain) do
    url = ApolloIo.Config.version() <> @organization_match_url
    opts = Map.merge(%{api_key: ApolloIo.Config.api_key()}, %{domain: domain})

    case ApolloIo.Config.new_request() |> Req.post!(url: url, json: opts) do
      %Req.Response{body: body, status: 200} -> {:ok, body}
      %Req.Response{body: body, status: _error} -> {:error, body}
    end
  end
end
