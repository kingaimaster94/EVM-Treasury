# EVM-Treasury
This is EVM Treasury wallet contract

## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

-   **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
-   **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
-   **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
-   **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Validator.s.sol:ValidatorScript --broadcast --rpc-url=https://rpc.canxium.org --private-key 
```

### Verify
```shell
$ forge verify-contract --compiler-version 0.8.25+commit.b61c2a91 --chain-id 3003 --optimizer-runs 200 0xeDDc3e40EE90D3A882e662D4bFde83eFCCa3Cef7 src/Validator.sol:Validator --etherscan-api-key MIQ2B1NB9WNVIN16P6EVC687UJDV65X78K --constructor-args $(cast abi-encode "constructor(address, uint256)" 0x7b7958d29C37522B3970211C4b72662Dd18b01DA 100000000000000000000)
```

this is comepleted.

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```
