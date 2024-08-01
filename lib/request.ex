defmodule ApolloIo.Request do
  @moduledoc """
  Documentation for `ApolloIo.Config`.
  """
  alias Req.Request

  @base_url ApolloIo.Config.base_url()
  @current_version "/v1"

  @type headers :: %{String.t() => String.t()}
  @type error :: ApolloIo.Error.t() | Exception.t()
  @doc """
  Create a new request with the base API url.
  """
  @spec post(String.t(), map()) ::
          {:ok, body: map(), headers: headers()} | {:error, error()}
  def post(url, opts) do
    url = @current_version <> url

    Req.new(base_url: @base_url)
    |> Request.put_headers([{"x-api-key", opts[:api_key]}])
    |> Req.post(url: url, json: opts, decode_body: false)
    |> decode_body()
    |> handle_response()
  end

  @spec get(String.t(), map()) ::
          {:ok, body: map(), headers: headers()} | {:error, error()}
  def get(url, opts) do
    url = @current_version <> url

    Req.new(base_url: @base_url)
    |> Request.put_headers([{"x-api-key", opts[:api_key]}])
    |> Req.get(url: url, params: opts, retry: retry_function(), decode_body: false)
    |> decode_body()
    |> handle_response()
  end

  defp decode_body({:ok, %Req.Response{status: status} = response})
       when status >= 200 and status < 300 do
    {:ok, update_in(response.body, &Jason.decode!/1)}
  end

  defp decode_body(response), do: response

  defp handle_response({:ok, %Req.Response{body: body, status: 200}}) when body == %{},
    do: {:error, %ApolloIo.Error{message: "Not found"}}

  defp handle_response({:ok, %Req.Response{body: body, status: 200, headers: headers}}),
    do: {:ok, body, headers}

  defp handle_response({:ok, %Req.Response{body: body, status: _error}}),
    do: {:error, %ApolloIo.Error{message: body}}

  defp handle_response(error), do: error

  def retry_function do
    case Application.get_env(:apollo_io, :retry_function) do
      nil -> :safe_transient
      function -> function
    end
  end
end
