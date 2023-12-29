// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {ERC20} from "solmate/tokens/ERC20.sol";
import {WETH} from "solmate/tokens/WETH.sol";
import {BaseChainSetup} from "./BaseChainSetup.sol";

contract WethMintHelper is BaseChainSetup {
    mapping(string => address) wethWhaleLookup;

    function _setupWhaleInfo() private {
        wethWhaleLookup["avalanche"] = address(
            0x5E12fc70B97902AC19B9cB87F2aC5a8593769779
        );
        wethWhaleLookup["polygon"] = address(
            0x1eED63EfBA5f81D95bfe37d82C8E736b974F477b
        );
    }

    function setupWethHelperInfo() public {
        _setupWhaleInfo();
    }

    function mintWrappedTo(
        string memory chain,
        address to,
        uint256 amount
    ) public {
        startImpersonating(to);
        dealTo(chain, to, to.balance + amount);
        WETH(getWrapped(chain)).deposit{value: amount}();
        stopImpersonating();
    }

    function mintWethTo(
        string memory chain,
        address to,
        uint256 amount
    ) public {
        switchTo(chain);
        if (gasEthLookup[chain]) {
            mintWrappedTo(chain, to, amount);
        } else {
            address whale = wethWhaleLookup[chain];
            if (whale == address(0)) {
                revert(string.concat("no weth whale for chain ", chain));
            }
            dealTo(chain, whale, 1 ether);
            startImpersonating(whale);
            ERC20(wethLookup[chain]).transfer(to, amount);
            stopImpersonating();
        }
    }
}
