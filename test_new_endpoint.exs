# Test script to verify the new /mixed_people/api_search endpoint works
# Run with: mix run test_new_endpoint.exs

# Test raw API call first
api_key = System.get_env("ENAIA_APOLLO_IO_API_KEY")
IO.puts("Testing new endpoint /mixed_people/api_search...")
IO.puts("API Key present: #{!is_nil(api_key)}")

# Make raw request to see response structure
result = Req.new(base_url: "https://api.apollo.io")
|> Req.Request.put_headers([{"x-api-key", api_key}])
|> Req.post(
  url: "/v1/mixed_people/api_search",
  json: %{
    person_titles: ["CEO"],
    q_organization_domains: "enaia.co",
    page: 1
  }
)

case result do
  {:ok, %Req.Response{status: 200, body: body}} ->
    IO.puts("\n✅ RAW REQUEST SUCCESS!")
    IO.puts("\nResponse structure:")
    IO.inspect(Map.keys(body), label: "Top-level keys")

    if Map.has_key?(body, "people") do
      IO.puts("\npeople key found - #{length(body["people"])} results")
    end
    if Map.has_key?(body, "contacts") do
      IO.puts("contacts key found - #{length(body["contacts"])} results")
    end

  {:ok, %Req.Response{status: status, body: body}} ->
    IO.puts("\n❌ HTTP Error #{status}")
    IO.inspect(body)

  {:error, error} ->
    IO.puts("\n❌ REQUEST ERROR!")
    IO.inspect(error)
end
