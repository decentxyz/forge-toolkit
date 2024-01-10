// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {LzChainSetup} from "./LzChainSetup.sol";

contract LzChainsInfo is LzChainSetup {
  function setupLzChainInfo() public {
    // configureLzChain(chain, lzId, lzEndpoint);
    configureLzChain("ethereum", 101, 0x66A71Dcef29A0fFBDBE3c6a460a3B5BC225Cd675);
    configureLzChain("sepolia", 10161, 0xae92d5aD7583AD66E49A0c67BAd18F6ba52dDDc1);
    configureLzChain("arbitrum", 110, 0x3c2269811836af69497E5F486A85D7316753cf62);
    configureLzChain("arbitrum_goerli", 10143, 0x6aB5Ae6822647046626e83ee6dB8187151E1d5ab);
    configureLzChain("arbitrum_sepolia", 10231, 0x6098e96a28E02f27B1e6BD381f870F1C8Bd169d3);
    configureLzChain("optimism", 111, 0x3c2269811836af69497E5F486A85D7316753cf62);
    configureLzChain("optimism_goerli", 10132, 0xae92d5aD7583AD66E49A0c67BAd18F6ba52dDDc1);
    configureLzChain("optimism_sepolia", 10232, 0x55370E0fBB5f5b8dAeD978BA1c075a499eB107B8);
    configureLzChain("base", 184, 0xb6319cC6c8c27A8F5dAF0dD3DF91EA35C4720dd7);
    configureLzChain("base_goerli", 10160, 0x6aB5Ae6822647046626e83ee6dB8187151E1d5ab);
    configureLzChain("zora", 195, 0xb6319cC6c8c27A8F5dAF0dD3DF91EA35C4720dd7);
    configureLzChain("zora_goerli", 10195, 0x83c73Da98cf733B03315aFa8758834b36a195b87);
    configureLzChain("polygon", 109, 0x3c2269811836af69497E5F486A85D7316753cf62);
    configureLzChain("polygon_mumbai", 10109, 0xf69186dfBa60DdB133E91E9A4B5673624293d8F8);
    configureLzChain("avalanche", 106, 0x3c2269811836af69497E5F486A85D7316753cf62);
    configureLzChain("avalanche_fuji", 10106, 0x93f54D755A063cE7bB9e6Ac47Eccc8e33411d706);
    configureLzChain("fantom", 112, 0xb6319cC6c8c27A8F5dAF0dD3DF91EA35C4720dd7);
    configureLzChain("fantom_testnet", 10112, 0x7dcAD72640F835B0FA36EFD3D6d3ec902C7E5acf);
    configureLzChain("moonbeam", 126, 0x9740FF91F1985D8d2B71494aE1A2f723bb3Ed9E4);
    configureLzChain("moonbeam_testnet", 10126,  0xb23b28012ee92E8dE39DEb57Af31722223034747);
    configureLzChain("rarible_testnet", 10235, 0x83c73Da98cf733B03315aFa8758834b36a195b87);
  }
}
