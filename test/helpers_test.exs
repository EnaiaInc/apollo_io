defmodule ApolloIo.HelpersTest do
  use ExUnit.Case, async: true

  alias ApolloIo.Helpers

  describe "parse_headers/1" do
    test "parses valid numeric header values" do
      headers = [
        {"x-minute-usage", ["10"]},
        {"x-rate-limit-minute", ["100"]},
        {"x-minute-requests-left", ["90"]},
        {"x-hourly-usage", ["50"]},
        {"x-rate-limit-hourly", ["1000"]},
        {"x-hourly-requests-left", ["950"]},
        {"x-24-hour-usage", ["200"]},
        {"x-rate-limit-24-hour", ["10000"]},
        {"x-24-hour-requests-left", ["9800"]}
      ]

      rate_limit = Helpers.parse_headers(headers)

      assert rate_limit.minute.usage == 10
      assert rate_limit.minute.limit == 100
      assert rate_limit.minute.requests_left == 90

      assert rate_limit.hourly.usage == 50
      assert rate_limit.hourly.limit == 1000
      assert rate_limit.hourly.requests_left == 950

      assert rate_limit.daily.usage == 200
      assert rate_limit.daily.limit == 10000
      assert rate_limit.daily.requests_left == 9800
    end

    test "skips non-numeric header values gracefully" do
      headers = [
        {"x-minute-usage", ["10"]},
        {"x-rate-limit-minute", ["100"]},
        {"x-minute-requests-left", ["90"]},
        # Non-numeric values that should be skipped
        {"x-hourly-usage", ["..."]},
        {"x-rate-limit-hourly", ["invalid"]},
        {"x-hourly-requests-left", ["N/A"]},
        {"x-24-hour-usage", ["200"]},
        {"x-rate-limit-24-hour", ["10000"]},
        {"x-24-hour-requests-left", ["9800"]}
      ]

      # Should not raise ArgumentError
      rate_limit = Helpers.parse_headers(headers)

      # Minute values should be present
      assert rate_limit.minute.usage == 10
      assert rate_limit.minute.limit == 100
      assert rate_limit.minute.requests_left == 90

      # Hourly values should be nil/empty (skipped due to invalid values)
      assert rate_limit.hourly.usage == nil
      assert rate_limit.hourly.limit == nil
      assert rate_limit.hourly.requests_left == nil

      # Daily values should be present
      assert rate_limit.daily.usage == 200
      assert rate_limit.daily.limit == 10000
      assert rate_limit.daily.requests_left == 9800
    end

    test "handles partially numeric strings (should skip them)" do
      headers = [
        {"x-minute-usage", ["123abc"]},
        {"x-rate-limit-minute", ["100extra"]},
        {"x-minute-requests-left", ["90"]}
      ]

      rate_limit = Helpers.parse_headers(headers)

      # Only fully numeric values should be parsed
      assert rate_limit.minute.usage == nil
      assert rate_limit.minute.limit == nil
      assert rate_limit.minute.requests_left == 90
    end

    test "handles empty header list" do
      rate_limit = Helpers.parse_headers([])

      assert rate_limit.minute.usage == nil
      assert rate_limit.minute.limit == nil
      assert rate_limit.minute.requests_left == nil

      assert rate_limit.hourly.usage == nil
      assert rate_limit.hourly.limit == nil
      assert rate_limit.hourly.requests_left == nil

      assert rate_limit.daily.usage == nil
      assert rate_limit.daily.limit == nil
      assert rate_limit.daily.requests_left == nil
    end
  end
end
