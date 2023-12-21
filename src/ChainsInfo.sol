// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {BaseChainSetup} from "./BaseChainSetup.sol";

contract ChainsInfo is BaseChainSetup {
    address OP_STACK_WETH = 0x4200000000000000000000000000000000000006;

    function configureOptimism() private {
        configureChain("optimism", true, 10, OP_STACK_WETH);
    }

    function configureBase() private {
        configureChain("base", true, 8453, OP_STACK_WETH);
    }

    function configureArbitrum() private {
        configureChain(
            "arbitrum",
            true,
            42161,
            0x82aF49447D8a07e3bd95BD0d56f35241523fBab1
        );
    }

    function configureEthereum() private {
        configureChain(
            "ethereum",
            true,
            1,
            0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2
        );
    }

    function configureSepolia() private {
        configureChain(
            "sepolia",
            true,
            11155111,
            0x7b79995e5f793A07Bc00c21412e50Ecae098E7f9
        );
    }

    function configureFtmTestnet() private {
        configureChain(
            "ftm-testnet",
            false,
            4002,
            0x84c7dd519ea924bf1cf6613f9127f26d7ab801d0,
            0x07b9c47452c41e8e00f98ac4c075f5c443281d2a
        );
    }

    function configureZora() private {
        configureChain("zora", true, 7777777, OP_STACK_WETH);
    }

    function configureZoraGoerli() private {
        configureChain("zora-goerli", true, 999, OP_STACK_WETH);
    }

    function configureOptimismGoerli() private {
        configureChain("optimism-goerli", true, 420, OP_STACK_WETH);
    }

    function configureAvalanche() private {
        configureChain(
            "avalanche",
            false,
            43114,
            0x49D5c2BdFfac6CE2BFdB6640F4F80f226bc10bAB,
            0xb31f66aa3c1e785363f0875a1b74e27b85fd66c7
        );
    }

    function configurePolygon() private {
        configureChain(
            "polygon",
            false,
            137,
            0x7ceB23fD6bC0adD59E62ac25578270cFf1b9f619,
            0x0d500b1d8e8ef31e21c99d1db9a6444d3adf1270
        );
    }

    function setupChainInfo() public {
        configureSepolia();
        configureOptimismGoerli();
        configureZoraGoerli();
        configureFtmTestnet();
        configureEthereum();
        configureArbitrum();
        configureOptimism();
        configureBase();
        configureZora();
        configureAvalanche();
        configurePolygon();
    }
}
