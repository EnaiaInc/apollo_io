defmodule ApolloIo.Helpers do
  @moduledoc """
  Helpers
  """
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
