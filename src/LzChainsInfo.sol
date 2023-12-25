// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {LzChainSetup} from "./LzChainSetup.sol";

contract LzChainsInfo is LzChainSetup {
    function configureOptimismLz() private {
        configureLzChain(
            "optimism",
            111,
            0x3c2269811836af69497E5F486A85D7316753cf62,
            0x4D73AdB72bC3DD368966edD0f0b2148401A178E2
        );
    }

    function configureBaseLz() private {
        configureLzChain(
            "base",
            184,
            0xb6319cC6c8c27A8F5dAF0dD3DF91EA35C4720dd7,
            0x38dE71124f7a447a01D67945a51eDcE9FF491251
        );
    }

    function configureArbitrumLz() private {
        configureLzChain(
            "arbitrum",
            110,
            0x3c2269811836af69497E5F486A85D7316753cf62,
            0x4D73AdB72bC3DD368966edD0f0b2148401A178E2
        );
    }

    function configureEthereumLz() private {
        configureLzChain(
            "ethereum",
            101,
            0x66A71Dcef29A0fFBDBE3c6a460a3B5BC225Cd675,
            0x4D73AdB72bC3DD368966edD0f0b2148401A178E2
        );
    }

    function configureSepoliaLz() private {
        configureLzChain(
            "sepolia",
            10161,
            0xae92d5aD7583AD66E49A0c67BAd18F6ba52dDDc1,
            0x3aCAAf60502791D199a5a5F0B173D78229eBFe32
        );
    }

    function configureFtmTestnetLz() private {
        configureLzChain(
            "ftm-testnet",
            10112,
            0x7dcAD72640F835B0FA36EFD3D6d3ec902C7E5acf,
            0x54109D468858d8f460587b7B4C1B950c9aB48CBd
        );
    }

    function configureZoraLz() private {
        configureLzChain(
            "zora",
            195,
            0xb6319cC6c8c27A8F5dAF0dD3DF91EA35C4720dd7,
            0x38dE71124f7a447a01D67945a51eDcE9FF491251
        );
    }

    function configureZoraGoerliLz() private {
        configureLzChain(
            "zora-goerli",
            10195,
            0x83c73Da98cf733B03315aFa8758834b36a195b87,
            0x55370E0fBB5f5b8dAeD978BA1c075a499eB107B8
        );
    }

    function configureOptimismGoerliLz() private {
        configureLzChain(
            "optimism-goerli",
            10132,
            0xae92d5aD7583AD66E49A0c67BAd18F6ba52dDDc1,
            0x7343d5c9811FcCb45F64073f0bB7482b37028dc8
        );
    }

    function configureAvalancheLz() private {
        configureLzChain(
            "avalanche",
            106,
            0x3c2269811836af69497E5F486A85D7316753cf62,
            0x4D73AdB72bC3DD368966edD0f0b2148401A178E2
        );
    }

    function configurePolygonLz() private {
        configureLzChain(
            "polygon",
            109,
            0x3c2269811836af69497E5F486A85D7316753cf62,
            0x4D73AdB72bC3DD368966edD0f0b2148401A178E2
        );
    }

    function setupLzChainInfo() public {
        configureSepoliaLz();
        configureOptimismGoerliLz();
        configureZoraGoerliLz();
        configureFtmTestnetLz();
        configureEthereumLz();
        configureArbitrumLz();
        configureOptimismLz();
        configureBaseLz();
        configureZoraLz();
        configureAvalancheLz();
        configurePolygonLz();
    }
}
