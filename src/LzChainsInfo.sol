// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {LzChainSetup} from "./LzChainSetup.sol";

contract LzChainsInfo is LzChainSetup {
  function setupLzChainInfo() public {
    // configureLzChain(chain, lzId, lzEndpoint);
    configureLzChain("ethereum", 30101, 0x1a44076050125825900e736c501f859c50fE728c);
    configureLzChain("sepolia", 40161, 0x6EDCE65403992e310A62460808c4b910D972f10f);
    configureLzChain("arbitrum", 30110, 0x1a44076050125825900e736c501f859c50fE728c);
    configureLzChain("arbitrum_sepolia", 40231, 0x6EDCE65403992e310A62460808c4b910D972f10f);
    configureLzChain("optimism", 30111, 0x1a44076050125825900e736c501f859c50fE728c);
    configureLzChain("optimism_sepolia", 40232, 0x6EDCE65403992e310A62460808c4b910D972f10f);
    configureLzChain("base", 30184, 0x1a44076050125825900e736c501f859c50fE728c);
    configureLzChain("base_sepolia", 40245, 0x6EDCE65403992e310A62460808c4b910D972f10f);
    configureLzChain("zora", 30195, 0x1a44076050125825900e736c501f859c50fE728c);
    configureLzChain("zora_sepolia", 40249, 0x6EDCE65403992e310A62460808c4b910D972f10f);
    configureLzChain("polygon", 30109, 0x1a44076050125825900e736c501f859c50fE728c);
    configureLzChain("polygon_mumbai", 40109, 0x6EDCE65403992e310A62460808c4b910D972f10f);
    configureLzChain("avalanche", 30106, 0x1a44076050125825900e736c501f859c50fE728c);
    configureLzChain("avalanche_fuji", 40106, 0x6EDCE65403992e310A62460808c4b910D972f10f);
    configureLzChain("fantom", 30112, 0x1a44076050125825900e736c501f859c50fE728c);
    configureLzChain("fantom_testnet", 40112, 0x6EDCE65403992e310A62460808c4b910D972f10f);
    configureLzChain("moonbeam", 30126, 0x1a44076050125825900e736c501f859c50fE728c);
    configureLzChain("moonbeam_testnet", 40126,  0x6EDCE65403992e310A62460808c4b910D972f10f);
    configureLzChain("rarible", 30235, 0x1a44076050125825900e736c501f859c50fE728c);
    configureLzChain("rarible_testnet", 40235, 0x6EDCE65403992e310A62460808c4b910D972f10f);
  }
}
