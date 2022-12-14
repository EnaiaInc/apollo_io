defmodule ApolloIo.Search do
  @moduledoc """
  Documentation for `ApolloIo.Search`.
  """
  alias ApolloIo.PostBehaviour

  @search_url "/mixed_people/search"
  @service Confex.get_env(:apollo_io, :search_client)

  @doc """
  Query the endpoint.
  Options parameters are passed as a map.
  person_titles (options) - list os titles
  q_organization_domains (optional) - list of domains
  page (optional) - integer
  ref: https://apolloio.github.io/apollo-api-docs/?shell#search
  """
  def search(opts), do: @service.post_request(opts)

  @behaviour PostBehaviour
  def post_request(opts) do
    url = ApolloIo.Config.version() <> @search_url
    opts = Map.merge(%{api_key: ApolloIo.Config.api_key()}, opts)

    case ApolloIo.Config.new_request() |> Req.post!(url: url, json: opts) do
      %Req.Response{body: body, status: 200} -> {:ok, body}
      %Req.Response{body: body, status: _error} -> {:error, body}
    end
  end
end
