// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {LzChainSetup} from "./LzChainSetup.sol";

library UsdcAddress {
    address constant ethereum = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;
    address constant arbitrum = 0xFF970A61A04b1cA14834A43f5dE4533eBDDB5CC8;
    address constant optimism = 0x7F5c764cBc14f9669B88837ca1490cCa17c31607;
    address constant polygon = 0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174;
    address constant avalanche = 0xB97EF9Ef8734C71904D8002F8b6Bc66Dd9c48a6E;
}

library SgEthAddress {
    address constant ethereum = 0xdf0770dF86a8034b3EFEf0A1Bb3c889B8332FF56;
    address constant arbitrum = 0x915A55e36A01285A14f05dE6e81ED9cE89772f8e;
    address constant optimism = 0xd22363e3762cA7339569F3d33EADe20127D5F98C;
}

contract SgChainsInfo is LzChainSetup {
    mapping(string => address) sgRouterLookup;
    mapping(string => address) sgBridgeLookup;
    mapping(string => address) sgComposerLookup;
    mapping(string => mapping(address => uint120)) sgPoolIdLookup;
    uint8 internal constant TYPE_SWAP_REMOTE = 1;

    address constant STARGATE_COMMON_COMPOSER =
        0xeCc19E177d24551aA7ed6Bc6FE566eCa726CC8a9;

    // from here https://stargateprotocol.gitbook.io/stargate/developers/contract-addresses/mainnet
    function addBridge(string memory chain, address _address) private {
        sgBridgeLookup[chain] = _address;
        vm.label(_address, string.concat("stargate_bridge_", chain));
    }

    function addRouter(string memory chain, address _address) private {
        sgRouterLookup[chain] = _address;
        vm.label(_address, string.concat("stargate_router_", chain));
    }

    function addComposer(string memory chain, address _address) private {
        sgComposerLookup[chain] = _address;
        vm.label(_address, string.concat("stargate_composer_", chain));
    }

    function setupSgChainInfo() public {
        addRouter("ethereum", 0x8731d54E9D02c286767d56ac03e8037C07e01e98);
        addRouter("avalanche", 0x45A01E4e04F14f7A4a6702c74187c5F6222033cd);
        addRouter("polygon", 0x45A01E4e04F14f7A4a6702c74187c5F6222033cd);
        addRouter("arbitrum", 0x53Bf833A5d6c4ddA888F69c22C88C9f356a41614);
        addRouter("optimism", 0xB0D502E938ed5f4df2E681fE6E419ff29631d62b);
        addRouter("fantom", 0xAf5191B0De278C7286d6C7CC6ab6BB8A73bA2Cd6);
        addRouter("metis", 0x2F6F07CDcf3588944Bf4C42aC74ff24bF56e7590);
        addRouter("base", 0x45f1A95A4D3f3836523F5c83673c797f4d4d263B);
        addRouter("linea", 0x2F6F07CDcf3588944Bf4C42aC74ff24bF56e7590);
        addRouter("kava", 0x2F6F07CDcf3588944Bf4C42aC74ff24bF56e7590);
        addRouter("mantle", 0x2F6F07CDcf3588944Bf4C42aC74ff24bF56e7590);

        addComposer("ethereum", STARGATE_COMMON_COMPOSER);
        addComposer("arbitrum", STARGATE_COMMON_COMPOSER);
        addComposer("optimism", STARGATE_COMMON_COMPOSER);
        addComposer("avalanche", STARGATE_COMMON_COMPOSER);
        addComposer("polygon", STARGATE_COMMON_COMPOSER);
        addComposer("fantom", STARGATE_COMMON_COMPOSER);
        addComposer("base", STARGATE_COMMON_COMPOSER);
        addComposer("metis", STARGATE_COMMON_COMPOSER);
        addComposer("linea", STARGATE_COMMON_COMPOSER);
        addComposer("kava", STARGATE_COMMON_COMPOSER);
        addComposer("mantle", 0x296F55F8Fb28E498B858d0BcDA06D955B2Cb3f97);
        vm.label(STARGATE_COMMON_COMPOSER, "stargate_composer");

        addBridge("ethereum", 0x296F55F8Fb28E498B858d0BcDA06D955B2Cb3f97);
        addBridge("arbitrum", 0x352d8275AAE3e0c2404d9f68f6cEE084B5bEB3DD);
        addBridge("optimism", 0x701a95707A0290AC8B90b3719e8EE5b210360883);
        addBridge("polygon", 0x9d1B1669c73b033DFe47ae5a0164Ab96df25B944);
        addBridge("base", 0xAF54BE5B6eEc24d6BFACf1cce4eaF680A8239398);
        addBridge("avalanche", 0x9d1B1669c73b033DFe47ae5a0164Ab96df25B944);
        addBridge("fantom", 0x45A01E4e04F14f7A4a6702c74187c5F6222033cd);

        sgPoolIdLookup["ethereum"][UsdcAddress.ethereum] = 1;
        sgPoolIdLookup["ethereum"][SgEthAddress.ethereum] = 13;
        sgPoolIdLookup["arbitrum"][UsdcAddress.arbitrum] = 1;
        sgPoolIdLookup["arbitrum"][SgEthAddress.arbitrum] = 13;
        sgPoolIdLookup["optimism"][UsdcAddress.optimism] = 1;
        sgPoolIdLookup["optimism"][SgEthAddress.optimism] = 13;
        sgPoolIdLookup["polygon"][UsdcAddress.polygon] = 1;
        sgPoolIdLookup["avalanche"][UsdcAddress.avalanche] = 1;
    }
}
