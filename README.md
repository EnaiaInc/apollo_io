# ApolloIo

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `apollo_io` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:apollo_io, "~> 0.1.0"}
  ]
end
```

## Usage
No additional configuration is needed.
Pass your api_key on every request:

```elixir
AppoloIo.people_enrich("you_api_key", %{email: "email@domain.com"})
AppoloIo.organization_enrich("you_api_key", "some.domain.com")
AppoloIo.search("you_api_key", %{person_titles: ["sales director"]})
```

Supported params for `people_enrich` are:
  - first_name (optional)
  - last_name (optional)
  - name (optional)
  - email (optional)
  - organization_name (optional)
  - domain (optional)
  - id (optional)

Supported params for `organization_enrich` are:
  - person_titles (options) - list os titles
  - q_organization_domains (optional) - list of domains
  - page (optional) - integer
