// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {console2} from "forge-std/console2.sol";
import {CommonBase} from "forge-std/Base.sol";
import {ERC20} from "solmate/tokens/ERC20.sol";

contract BaseChainSetup is CommonBase {
    string private runtime;

    string constant ENV_FORGE_TEST = "forge-test";
    string constant ENV_FORK = "fork";
    string constant ENV_TESTNET = "testnet";
    string constant ENV_MAINNET = "mainnet";

    bool broadcasting = false;

    mapping(string => uint256) forkLookup;
    mapping(string => bool) gasEthLookup;
    mapping(string => address) wethLookup;
    mapping(string => address) wrappedLookup;
    mapping(string => uint256) chainIdLookup;

    function wethBalance(
        string memory chain,
        address user
    ) public view returns (uint) {
        return ERC20(getWeth(chain)).balanceOf(user);
    }

    function wrappedBalance(
        string memory chain,
        address user
    ) public view returns (uint) {
        return ERC20(getWrapped(chain)).balanceOf(user);
    }

    function getWeth(
        string memory chain
    ) public view returns (address payable) {
        return payable(_getTokenForChain(chain, "weth", wethLookup));
    }

    function getWrapped(
        string memory chain
    ) public view returns (address payable) {
        return payable(_getTokenForChain(chain, "wrapped", wrappedLookup));
    }

    function _getTokenForChain(
        string memory chain,
        string memory tokenName,
        mapping(string => address) storage lookup
    ) private view returns (address) {
        address token = payable(lookup[chain]);
        require(
            token != address(0),
            string.concat("no ", tokenName, " found for chain: ", chain)
        );
        return token;
    }

    function isMainnet() public returns (bool) {
        return vm.envOr("MAINNET", false) && strCompare(runtime, ENV_MAINNET);
    }

    function isTestnet() public returns (bool) {
        return vm.envOr("TESTNET", false) && strCompare(runtime, ENV_TESTNET);
    }

    function strCompare(
        string memory s1,
        string memory s2
    ) public pure returns (bool) {
        return
            keccak256(abi.encodePacked(s1)) == keccak256(abi.encodePacked(s2));
    }

    function isForgeTest() public view returns (bool) {
        return strCompare(runtime, ENV_FORGE_TEST);
    }

    function isForkRuntime() public view returns (bool) {
        return strCompare(runtime, ENV_FORK);
    }

    function setRuntime(string memory _runtime) internal {
        runtime = _runtime;
    }

    function _forkAlias(
        string memory _chain
    ) internal view returns (string memory) {
        return isForkRuntime() ? string.concat("fork_", _chain) : _chain;
    }

    function startImpersonating(address _as) internal {
        console2.log("impersonating as", _as);
        if (isForgeTest()) {
            vm.startPrank(_as);
        } else if (isForkRuntime()) {
            vm.stopBroadcast();
            vm.startBroadcast(_as);
        }
    }

    function configureChain(
        string memory chain,
        bool isGasEth,
        uint256 chainId,
        address weth
    ) public {
        configureChain(chain, isGasEth, chainId, weth, weth);
    }

    function configureChain(
        string memory chain,
        bool isGasEth,
        uint256 chainId,
        address weth,
        address wrapped
    ) public {
        try vm.createFork(_forkAlias(chain)) returns (uint256 forkId) {
            forkLookup[chain] = forkId;
        } catch {}
        gasEthLookup[chain] = isGasEth;
        vm.label(weth, string.concat(chain, "_WETH"));
        wethLookup[chain] = weth;
        if (weth != wrapped) {
            vm.label(wrapped, string.concat(chain, "_WRAPPED"));
        }
        wrappedLookup[chain] = wrapped;
        chainIdLookup[chain] = chainId;
    }

    function stopImpersonating() internal {
        if (isForgeTest()) {
            vm.stopPrank();
        } else {
            vm.stopBroadcast();
            vm.startBroadcast();
        }
    }

    function switchTo(string memory chain) internal {
        if (bytes(chain).length == 0) {
            revert("no chain specified");
        }

        if (!isForgeTest() && broadcasting) {
            vm.stopBroadcast();
            broadcasting = false;
        }

        uint forkId = forkLookup[chain];

        vm.selectFork(forkId);

        if (block.chainid != chainIdLookup[chain]) {
            revert(string.concat("chainId mismatch for chain: ", chain));
        }

        if (!isForgeTest()) {
            vm.startBroadcast();
            broadcasting = true;
        }
    }

    function dealTo(
        string memory chain,
        address user,
        uint256 amount
    ) internal returns (bool success) {
        success = true;
        switchTo(chain);
        if (isForgeTest()) {
            vm.deal(user, amount);
        } else {
            (success, ) = user.call{value: amount}("");
        }
    }
}
