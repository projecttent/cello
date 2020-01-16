defmodule Cello.Shell do
  def run(cmd, args) when is_binary(cmd) and is_list(args) do
    case System.cmd(cmd, args) do
      {result, 0} -> {:ok, result}
      {error, _} -> {:error, error}
    end
  end
end
