defmodule Cello.Account do
  alias Cello.Shell
  alias Decimal, as: D

  @min_dollar_balance "2000000000000000000"

  def get_available_dollars(account) when is_binary(account) do
    {:ok, result} = Shell.run("celocli", ["account:balance", account])

    balance =
      result
      |> String.split("\n", trim: true)
      |> List.delete_at(0)
      |> Enum.map(&parse_balance/1)
      |> dollar_amount()

    case D.cmp(balance, @min_dollar_balance) do
      :gt -> D.sub(balance, @min_dollar_balance)
      _ -> D.new("0")
    end
  end

  defp parse_balance("gold: " <> amount) do
    %{gold: amount}
  end

  defp parse_balance("lockedGold: " <> amount) do
    %{locked_gold: amount}
  end

  defp parse_balance("usd: " <> amount) do
    %{usd: amount}
  end

  defp parse_balance("total: " <> amount) do
    %{total: amount}
  end

  defp dollar_amount(amounts) when is_list(amounts) do
    amounts
    |> Enum.filter(&Map.has_key?(&1, :usd))
    |> Enum.map(fn %{usd: amount} -> amount end)
    |> List.first()
  end
end
