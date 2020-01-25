defmodule Cello.Vote do
  alias Cello.Shell

  def mark_vote({account, amount}, candidate) do
    {:ok, result} =
      Shell.run("celocli", [
        "election:vote",
        "--from=#{account}",
        "--value=#{amount}",
        "--for=#{candidate}"
      ])

    IO.puts(result)

    account
  end

  def activate_votes([voter, candidate]) do
    IO.puts("Activating votes from #{voter} and #{candidate}. Please wait...")

    result =
      :os.cmd(
        'celocli election:activate --from #{voter} --wait && celocli election:activate --from #{
          candidate
        }'
      )

    IO.puts(result)

    :ok
  end
end
