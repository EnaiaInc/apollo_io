defmodule ApolloIo.Config do
  @moduledoc """
  Documentation for `ApolloIo.Config`.
  """

  @base_url "https://api.apollo.io"
  @current_version "/v1"
  @doc """
  Create a new request with the base API url.
  """
  def new_request, do: Req.new(base_url: @base_url)

  @doc """
  Fetch the current API version to use.
  """
  def version, do: @current_version
end
