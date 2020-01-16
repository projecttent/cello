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
    dollar_balances =
      [@validator, @validator_group]
      |> Enum.map(&Account.get_available_dollars/1)

    output = """

    > Balances:
    >   #{List.first(dollar_balances)}
    >   #{List.last(dollar_balances)}
    """

    Mix.shell().info(output)
  end
end
