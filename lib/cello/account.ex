defmodule Cello.Account do
  alias Cello.Shell
  alias Decimal, as: D

  @min_dollar_balance "2000000000000000000"
  @min_gold_balance "2000000000000000000"

  def get_available_dollars(account) when is_binary(account) do
    {:ok, result} = Shell.run("celocli", ["account:balance", account])

    IO.puts(result)

    amount =
      result
      |> String.split("\n", trim: true)
      |> List.delete_at(0)
      |> Enum.map(&parse_balance/1)
      |> dollar_amount()

    case D.cmp(amount, @min_dollar_balance) do
      :gt -> {account, D.sub(amount, @min_dollar_balance)}
      _ -> {account, "0"}
    end
  end

  def get_available_gold(account) do
    {:ok, result} = Shell.run("celocli", ["account:balance", account])

    IO.puts(result)

    amount =
      result
      |> String.split("\n", trim: true)
      |> List.delete_at(0)
      |> Enum.map(&parse_balance/1)
      |> gold_amount()

    case D.cmp(amount, @min_gold_balance) do
      :gt -> {account, D.sub(amount, @min_gold_balance)}
      _ -> {account, "0"}
    end
  end

  def exchange_dollars_for_gold({account, "0"}) when is_binary(account) do
    account
  end

  def exchange_dollars_for_gold({account, amount}) when is_binary(account) do
    {:ok, result} =
      Shell.run("celocli", ["exchange:dollars", "--from=#{account}", "--value=#{amount}"])

    IO.puts(result)
    account
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

  defp gold_amount(amounts) when is_list(amounts) do
    amounts
    |> Enum.filter(&Map.has_key?(&1, :gold))
    |> Enum.map(fn %{gold: amount} -> amount end)
    |> List.first()
  end
end
