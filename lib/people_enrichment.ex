defmodule ApolloIo.PeopleEnrichment do
  @moduledoc """
  Documentation for `ApolloIo.PeopleEnrichment`.
  """
  alias ApolloIo.PostBehaviour
  @service Confex.get_env(:apollo_io, :people_client)

  @people_match_url "/people/match"

  def people_enrich(opts), do: @service.post_request(opts)

  @doc """
  Query the endpoint.
  Optional parameters are passed as a map.
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
  @behaviour PostBehaviour
  def post_request(opts) do
    url = ApolloIo.Config.version() <> @people_match_url
    opts = Map.merge(%{api_key: ApolloIo.Config.api_key()}, opts)

    case ApolloIo.Config.new_request() |> Req.post!(url: url, json: opts) do
      %Req.Response{body: body, status: 200} -> {:ok, body}
      %Req.Response{body: body, status: _error} -> {:error, body}
    end
  end
end
