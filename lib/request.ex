defmodule ApolloIo.Request do
  @moduledoc """
  Documentation for `ApolloIo.Config`.
  """

  @base_url ApolloIo.Config.base_url()
  @current_version "/v1"
  @doc """
  Create a new request with the base API url.
  """
  def post(url, opts) do
    url = @current_version <> url

    opts =
      Map.merge(opts, %{
        api_key: api_key()
      })

    Req.new(base_url: @base_url)
    |> Req.post!(url: url, json: opts)
    |> case do
      %Req.Response{body: body, status: 200} when body == %{} ->
        {:error, %ApolloIo.Error{message: "Not found"}}

      %Req.Response{body: body, status: 200} ->
        {:ok, body}

      %Req.Response{body: body, status: _error} ->
        {:error, body}
    end
  end

  def get(url, opts) do
    url = @current_version <> url

    opts =
      Map.merge(opts, %{
        api_key: api_key()
      })

    Req.new(base_url: @base_url)
    |> Req.get!(url: url, params: opts, retry: retry_function(), decode_body: false)
    |> decode_body()
    |> case do
      %Req.Response{body: body, status: 200} when body == %{} ->
        {:error, %ApolloIo.Error{message: "Not found"}}

      %Req.Response{body: body, status: 200} ->
        {:ok, body}

      %Req.Response{body: body, status: _error} ->
        {:error, %ApolloIo.Error{message: body}}
    end
  end

  defp decode_body(%Req.Response{status: status} = response)
       when status >= 200 and status < 300 do
    update_in(response.body, &Jason.decode!/1)
  end

  defp decode_body(response), do: response

  @doc """
  Fetch the API key from application configuration
  """
  def api_key, do: Application.get_env(:apollo_io, :api_key)

  def retry_function do
    case Application.get_env(:apollo_io, :retry_function) do
      nil -> :safe
      function -> function
    end
  end
end
