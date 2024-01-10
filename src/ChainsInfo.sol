// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {BaseChainSetup} from "./BaseChainSetup.sol";

contract ChainsInfo is BaseChainSetup {
    address OP_STACK_WETH = 0x4200000000000000000000000000000000000006;

    function setupChainInfo() public {
        // configureChain(chain, isGasEth, chainId, weth, wrapped);
        configureChain("ethereum", true, 1, 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);
        configureChain("sepolia", true, 11155111, 0x7b79995e5f793A07Bc00c21412e50Ecae098E7f9);
        configureChain("arbitrum", true, 42161, 0x82aF49447D8a07e3bd95BD0d56f35241523fBab1);
        configureChain("arbitrum_goerli", , , );
        configureChain("arbitrum_sepolia", , , );
        configureChain("optimism", true, 10, OP_STACK_WETH);
        configureChain("optimism_goerli", true, 420, OP_STACK_WETH);
        configureChain("optimism_sepolia", , , );
        configureChain("base", true, 8453, OP_STACK_WETH);
        configureChain("base_goerli", , , );
        configureChain("zora", true, 7777777, OP_STACK_WETH);
        configureChain("zora_goerli", true, 999, OP_STACK_WETH);
        configureChain("polygon", false, 137, 0x7ceB23fD6bC0adD59E62ac25578270cFf1b9f619,  0x0d500B1d8E8eF31E21C99d1Db9A6444d3ADf1270);
        configureChain("polygon_mumbai", , , );
        configureChain("avalanche", false, 43114, 0x49D5c2BdFfac6CE2BFdB6640F4F80f226bc10bAB, 0xB31f66AA3C1e785363F0875A1B74E27b85FD66c7);
        configureChain("avalanche_fuji", , , );
        configureChain("fantom", , , );
        configureChain("fantom_testnet", false, 4002, 0x84C7dD519Ea924bf1Cf6613f9127F26D7aB801D0, 0x07B9c47452C41e8E00f98aC4c075F5c443281d2A);
        configureChain("moonbeam", , , );
        configureChain("moonbeam_testnet", , , );
        configureChain("rarible_testnet", , , );
    }
}
