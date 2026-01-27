ExUnit.start()
Application.ensure_all_started(:bypass)
Application.put_env(:apollo_io, :api_key, "test_api_key")
Application.put_env(:apollo_io, :base_url, "http://localhost:12345")
