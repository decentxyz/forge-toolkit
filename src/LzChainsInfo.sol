// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {LzChainSetup} from "./LzChainSetup.sol";

contract LzChainsInfo is LzChainSetup {
    address OP_STACK_WETH = 0x4200000000000000000000000000000000000006;

    function configureOptimism() private {
        configureLzChain(
            "optimism",
            111,
            0x3c2269811836af69497E5F486A85D7316753cf62
        );
    }

    function configureBase() private {
        configureLzChain(
            "base",
            184,
            0xb6319cC6c8c27A8F5dAF0dD3DF91EA35C4720dd7
        );
    }

    function configureArbitrum() private {
        configureLzChain(
            "arbitrum",
            110,
            address(0x3c2269811836af69497E5F486A85D7316753cf62)
        );
    }

    function configureEthereum() private {
        configureLzChain(
            "ethereum",
            101,
            0x66A71Dcef29A0fFBDBE3c6a460a3B5BC225Cd675
        );
    }

    function configureSepolia() private {
        configureLzChain(
            "sepolia",
            10161,
            0xae92d5aD7583AD66E49A0c67BAd18F6ba52dDDc1
        );
    }

    function configureFtmTestnet() private {
        configureLzChain(
            "ftm-testnet",
            10112,
            0x7dcAD72640F835B0FA36EFD3D6d3ec902C7E5acf
        );
    }

    function configureZora() private {
        configureLzChain(
            "zora",
            195,
            0xb6319cC6c8c27A8F5dAF0dD3DF91EA35C4720dd7
        );
    }

    function configureZoraGoerli() private {
        configureLzChain(
            "zora-goerli",
            10195,
            0x83c73Da98cf733B03315aFa8758834b36a195b87
        );
    }

    function configureOptimismGoerli() private {
        configureLzChain(
            "optimism-goerli",
            10132,
            0xae92d5aD7583AD66E49A0c67BAd18F6ba52dDDc1
        );
    }

    function configureAvalanche() private {
        configureLzChain(
            "avalanche",
            106,
            0x3c2269811836af69497E5F486A85D7316753cf62
        );
    }

    function configurePolygon() private {
        configureLzChain(
            "polygon",
            109,
            0x3c2269811836af69497E5F486A85D7316753cf62
        );
    }

    function setupLzChainInfo() public {
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
