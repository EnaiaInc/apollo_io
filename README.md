# Apollo.io client library

Elixir client for the [apollo.io API](https://apolloio.github.io/apollo-api-docs/?shell#introduction).

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

## Configuration

The API key can be added to the config as follows in the `config.exs` or `runtime.exs`:

```elixir
config :apollo_io,
  api_key: <YOUR_API_KEY>
```

## Usage

No additional configuration is needed.
Pass your api_key on every request:

```elixir
ApolloIo.people_enrich(email: "email@domain.com")
ApolloIo.organization_enrich("some.domain.com")
ApolloIo.search(person_titles: ["sales director"])
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
