// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {ChainsInfo} from "./ChainsInfo.sol";
import {LzChainsInfo} from "./LzChainsInfo.sol";

contract LoadAllChainInfo is ChainsInfo, LzChainsInfo {
    function loadAllChainInfo() public virtual {
        setupChainInfo();
        setupLzChainInfo();
    }
}
