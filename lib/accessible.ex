defmodule ApolloIo.Accessible do
  @moduledoc """
  Use this module to make a struct accessible like other maps, for example
  `pagination[:page]`.
  """
  defmacro __using__(_) do
    # Ref: https://elixirforum.com/t/ecto-and-access-behaviour/30623/2
    quote location: :keep do
      @behaviour Access
      @impl Access
      defdelegate fetch(term, key), to: Map
      defdelegate get(term, key, default), to: Map
      @impl Access
      defdelegate get_and_update(term, key, fun), to: Map
      @impl Access
      defdelegate pop(date, key), to: Map
    end
  end
end
