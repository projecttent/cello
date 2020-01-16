defmodule Mix.Tasks.Staker do
  use Mix.Task
  alias Cello.Account
  @validator "0bcdf73c45d99f33d1d8354980d7ca73c4cf72db"
  @validator_group "95785ce0ca05f23484342ca3c2337d7660b68d36"

  @shortdoc "Compounds earned rewards by restaking continuously."

  @moduledoc """
  Compounds earned rewards by restaking continuously.

  ## Example

  mix staker
  """

  def run(_args) do
    [@validator, @validator_group]
    |> Enum.map(&Account.get_available_dollars/1)
    |> Enum.map(&Account.exchange_dollars_for_gold/1)
    |> Enum.map(&Account.get_available_gold/1)
    |> Enum.map(&Account.lock_gold/1)

    output = """
    > Locked all available gold!
    """

    Mix.shell().info(output)
  end
end
