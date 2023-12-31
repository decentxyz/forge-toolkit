# Forge Toolkit

This repository contains suite of utility solidity smart contracts that
facilitate setting up scripts and tests. It's meant for reusability of
a lot of utility functions.

## `BaseChainSetup.sol`

This file is the base class. It has the following lookups:

```
    mapping(string => uint256) forkLookup;
    mapping(string => bool) gasEthLookup;
    mapping(string => address) wethLookup;
    mapping(string => address) wrappedLookup;
    mapping(string => uint256) chainIdLookup;
```

Classes like `ChainsInfo` subclass this and populate all those
lookup tables. This way you don't have to figure out
what `weth`'s address is in your scripts. They're provided
for you.

It also has utility functions such as:

### `wethBalance`

For getting a user's weth balance

### `wrappedBalance`

For getting wrapped balance for noneth chains

### `getWeth`

For getting weth address in a chain

### `getWrapped`

For getting wrapped asset address in noneth chains

### `isMainnet`

If the script is running in a mainnet environment

### `isTestnet`

Similar to above

### `isForgeTest`

If it's a forge unit-test

### `isForkRuntime`

If it's running in a forked environment

### `setRuntime`

For setting the runtime

### `startImpersonating`

For tests, it's `vm.startPrank`, and for scripts
it's `vm.startBroadcast`, for more info refer to
foundry 's [documentation](https://book.getfoundry.sh/cheatcodes/start-prank).

### `configureChain`

For populating the lookups shown above. They get used in the [ChainsInfo](src/ChainsInfo.sol)
contract.

### `switchTo`

Switches to a different chain. Conveniently this uses
a string as input which is the chain alias, defined in `foundry.toml` file.
Here's
[forge's](https://book.getfoundry.sh/cheatcodes/rpc?highlight=rpc_endpoints#examples)
documentation on how aliases are defined, and you can see
our aliases defined in
[utb](https://github.com/decentxyz/utb/blob/main/foundry.toml)
and
[decent bridge](https://github.com/decentxyz/decent-bridge/blob/main/foundry.toml)
under the `[rpc_endpoints]` section.

### `dealTo`

Deals money to the account. In the case of a test it uses `vm.deal`
and in case of scripts, just simply sends money to that address.

## `BalanceAssertions.sol`

[Utility functions](./src/BalanceAssertions.sol) for receiving native and wrapped balances. And asserting their values.

## `ChainAliases.sol`

[Some constants](./src/ChainAliases.sol) instead of using magic strings.

## `ChainsInfo.sol`

Contains a [utility function](./src/ChainsInfo.sol#L86) for populating all the lookup tables in the
`BaseChainSetup.sol`.

## `LzChainsSetup.sol`

Much like `BaseChainSetup.sol` but for LayerZero's chains. It has lookups for
their endpoints, their light nodes, their chain id's, etc.

## `LzChainsInfo.sol`

Much like `ChainsInfo.sol`, but for LayerZero's stuff. It also has utility functions for
delivering LayerZero's messages at the destination chain. An example of this can be seen
in the
[Decent Bridge's test-utilities](https://github.com/decentxyz/decent-bridge/blob/main/test/common/AliceAndBobScenario.sol#L93).

## `SgChainsInfo.sol`

Contains all the constants and lookups for Stargate's contracts.

## `UniswapRouterHelpers.sol`

Contains all the constants and lookups for Uniswap's Router & Quoter contracts.
It also has utility functions:

### `getUniRouter(string memory chain)`

Returns the address of the router for `chain`.

### `pathIn( string memory chain, address srcToken, address dstToken, uint24 tickSize )`

Creates a uniswap route path encoding for an `ExactAmountIn` route.
Refer to
[here](https://uniswapv3book.com/milestone_4/path.html?highlight=path#swap-path)
for more explanation about uniswap paths.

### `pathOut( string memory chain, address srcToken, address dstToken, uint24 tickSize )`

Same as above but for `ExactAmountOut`.

### `loadAllUniRouterInfo()`

Loads up the lookups and addresses.

## `UsdcHelper.sol`

Loads up usdc contract addresses in lookups so you can use them in tests and
scripts. It also has utility functions for minting usdc to a user.

### How does `mintUsdcTo` work?

The trick
here is to `impersonateAs` a whale, then have that whale submit some USDC to
the user's address.

## `WethMintHelper.sol`

Much like `UsdcHelper.sol` but for `WETH`.
