# Cello - Celo Restaker

## Description

Elixir CLI app for restaking rewards and keeping validators elected during TGCSO testnet. It handles the following tasks:

- cUSD rewards withdrawals
- cUSD for cGLD swaps
- validator voting
- validator vote activation

## Installation

- Install Elixir with `brew install elixir`
- Configure validator and validator group addresses.
- Run `mix cello stake`. This command should be run in a directory with access to your Celo local account.
