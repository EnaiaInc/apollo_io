defmodule ApolloIo.Search do
  @moduledoc """
  Documentation for `ApolloIo.Search`.
  """
  alias ApolloIo.{Contact, Person, Request, Helpers}

  defmodule SearchResult do
    @type t :: %__MODULE__{
            breadcrumbs: list,
            partial_results_only: boolean,
            partial_results_limit: integer,
            pagination: map,
            contacts: :list,
            people: :list
          }
    @derive Jason.Encoder
    defstruct [
      :breadcrumbs,
      :partial_results_only,
      :partial_results_limit,
      :pagination,
      :contacts,
      :people
    ]
  end

  @search_url "/mixed_people/search"

  @doc """
  Query the endpoint.
  Options parameters are passed as a keyword list.
  - person_titles (optional) - list of titles
  - person_past_organization_ids (optional) - list of organization ids
  - q_organization_domains (optional) - list of domains
  - page (optional) - integer
  ref: https://apolloio.github.io/apollo-api-docs/?shell#search
  """
  @spec search(keyword()) :: {:ok, SearchResult.t()} | {:error, map()}
  def search(opts) do
    opts = opts |> Enum.into(%{})

    case Request.post(@search_url, opts) do
      {:ok, body} ->
        {:ok, cast_to_struct(body)}

      {:error, body} ->
        {:error, body}
    end
  end

  defp cast_to_struct(body) do
    body
    |> Helpers.map_to_struct(SearchResult)
    |> Map.update(:contacts, nil, fn contacts ->
      Enum.map(contacts, &Helpers.map_to_struct(&1, Contact))
    end)
    |> Map.update(:people, nil, fn people ->
      Enum.map(people, &Person.cast_to_struct/1)
    end)
  end
end
