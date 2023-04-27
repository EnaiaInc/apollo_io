defmodule ApolloIo.Helpers do
  @moduledoc """
  Helpers
  """

  alias ApolloIo.RateLimit

  @minute_values [
    "x-minute-usage",
    "x-rate-limit-minute",
    "x-minute-requests-left"
  ]
  @hourly_values [
    "x-hourly-usage",
    "x-hourly-requests-left",
    "x-rate-limit-hourly"
  ]
  @daily_values [
    "x-24-hour-usage",
    "x-24-hour-requests-left",
    "x-rate-limit-24-hour"
  ]

  def parse_headers(headers) do
    minute_map = fetch_minute_map(headers)
    hourly_map = fetch_hourly_map(headers)
    daily_map = fetch_daily_map(headers)

    RateLimit.new(minute: minute_map, hourly: hourly_map, daily: daily_map)
  end

  defp fetch_minute_map(headers) do
    Enum.reduce(headers, %{}, fn {k, v}, acc ->
      if k in @minute_values, do: Map.put(acc, parse_key(k), String.to_integer(v)), else: acc
    end)
  end

  defp fetch_hourly_map(headers) do
    Enum.reduce(headers, %{}, fn {k, v}, acc ->
      if k in @hourly_values, do: Map.put(acc, parse_key(k), String.to_integer(v)), else: acc
    end)
  end

  defp fetch_daily_map(headers) do
    Enum.reduce(headers, %{}, fn {k, v}, acc ->
      if k in @daily_values, do: Map.put(acc, parse_key(k), String.to_integer(v)), else: acc
    end)
  end

  defp parse_key(key) do
    cond do
      String.contains?(key, "usage") -> :usage
      String.contains?(key, "left") -> :requests_left
      true -> :limit
    end
  end

  def map_to_struct(nil, _), do: nil

  def map_to_struct(map, module) do
    processed_map =
      Map.keys(module.__struct__)
      |> List.delete(:__struct__)
      |> Enum.reduce(%{}, fn key, acc ->
        value =
          Map.get(map, Atom.to_string(key))
          |> try_converting_common_value_formats()

        Map.put(acc, key, value)
      end)

    struct(module, processed_map)
  end

  def map_list_to_struct(nil, _module), do: []

  def map_list_to_struct(map_list, module) do
    Enum.map(map_list, &map_to_struct(&1, module))
  end

  defp try_converting_common_value_formats(value) do
    value
    |> maybe_convert_date()
    |> maybe_convert_datetime()
  end

  defp maybe_convert_datetime(value) when is_binary(value) do
    case DateTime.from_iso8601(value) do
      {:ok, datetime, 0} -> datetime
      _ -> value
    end
  end

  defp maybe_convert_datetime(value), do: value

  defp maybe_convert_date(value) when is_binary(value) do
    case Date.from_iso8601(value) do
      {:ok, date} -> date
      _ -> value
    end
  end

  defp maybe_convert_date(value), do: value
end
