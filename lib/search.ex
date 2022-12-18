defmodule ApolloIo.Search do
  @moduledoc """
  Documentation for `ApolloIo.Search`.
  """
  alias ApolloIo.PostBehaviour

  @search_url "/mixed_people/search"
  @service (if Mix.env() == :test do
              ApolloIo.SearchMock
            else
              ApolloIo.Search
            end)

  @doc """
  Query the endpoint.
  Options parameters are passed as a map.
  - person_titles (options) - list os titles
  - q_organization_domains (optional) - list of domains
  - page (optional) - integer
  ref: https://apolloio.github.io/apollo-api-docs/?shell#search
  """
  def search(api_key, opts), do: @service.post_request(api_key, opts)

  @behaviour PostBehaviour
  def post_request(api_key, opts) do
    url = ApolloIo.Config.version() <> @search_url
    opts = Map.merge(%{api_key: api_key}, opts)

    case ApolloIo.Config.new_request() |> Req.post!(url: url, json: opts) do
      %Req.Response{body: body, status: 200} -> {:ok, body}
      %Req.Response{body: body, status: _error} -> {:error, body}
    end
  end
end
