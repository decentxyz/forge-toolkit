// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {ChainsInfo} from "./ChainsInfo.sol";
import {LzChainsInfo} from "./LzChainsInfo.sol";
import {SgChainsInfo} from "./SgChainsInfo.sol";

contract LoadAllChainInfo is ChainsInfo, LzChainsInfo, SgChainsInfo {
    function loadAllChainInfo() public virtual {
        setupChainInfo();
        setupLzChainInfo();
        setupSgChainInfo();
    }
}
