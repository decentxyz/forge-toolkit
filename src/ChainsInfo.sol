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
        configureChain("arbitrum_nova", true, 42170, 0x722E8BdD2ce80A4422E880164f2079488e115365);
        configureChain("arbitrum_sepolia", true, 421614, 0x0133Ff8B0eA9f22e510ff3A8B245aa863b2Eb13F);
        configureChain("optimism", true, 10, OP_STACK_WETH);
        configureChain("optimism_sepolia", true, 11155420, OP_STACK_WETH);
        configureChain("base", true, 8453, OP_STACK_WETH);
        configureChain("base_sepolia", true, 84532, OP_STACK_WETH);
        configureChain("zora", true, 7777777, OP_STACK_WETH);
        configureChain("zora_sepolia", true, 999999999, OP_STACK_WETH);
        configureChain("polygon", false, 137, 0x7ceB23fD6bC0adD59E62ac25578270cFf1b9f619,  0x0d500B1d8E8eF31E21C99d1Db9A6444d3ADf1270);
        configureChain("polygon_amoy", false, 80002, 0x8154fC0b8601D781fd2D32B8099D0cE0eFe1dE18, 0x01805a841ece00cf680996bF4B4e21746C68Fd4e);
        configureChain("avalanche", false, 43114, 0x49D5c2BdFfac6CE2BFdB6640F4F80f226bc10bAB, 0xB31f66AA3C1e785363F0875A1B74E27b85FD66c7);
        // configureChain("avalanche_fuji", false, 43113, 0x0000000000000000000000000000000000000000, 0x0000000000000000000000000000000000000000);
        // configureChain("fantom", false, 250, 0x0000000000000000000000000000000000000000, 0x21be370D5312f44cB42ce377BC9b8a0cEF1A4C83);
        configureChain("fantom_testnet", false, 4002, 0x84C7dD519Ea924bf1Cf6613f9127F26D7aB801D0, 0x07B9c47452C41e8E00f98aC4c075F5c443281d2A);
        // configureChain("moonbeam", , , );
        // configureChain("moonbeam_testnet", , , );
        configureChain("rari", true, 1380012617, 0xf037540e51D71b2D2B1120e8432bA49F29EDFBD0);
        configureChain("rari_testnet", true, 1918988905, 0x2c9Dd2b2cd55266e3b5c3C95840F3c037fbCb856);
        configureChain("mantle", false, 5000, 0xdEAddEaDdeadDEadDEADDEAddEADDEAddead1111, 0x78c1b0C915c4FAA5FffA6CAbf0219DA63d7f4cb8);
        configureChain("mantle_sepolia", false, 5003, 0xdEAddEaDdeadDEadDEADDEAddEADDEAddead1111, 0xDC1f593f30F533b460F092cc2AcfbCA0715A4040);
        configureChain("mode", true, 34443, OP_STACK_WETH);
        configureChain("mode_sepolia", true, 919, 0x5CE359Ff65f8bc3c874c16Fa24A2c1fd26bB57CD);
        configureChain("zksync", true, 324, 0x5AEa5775959fBC2557Cc8789bC1bf90A239D9a91);
        configureChain("bnb", false, 56, 0x2170Ed0880ac9A755fd29B2688956BD959F933F8, 0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c);
        configureChain("opbnb", false, 204, 0xE7798f023fC62146e8Aa1b36Da45fb70855a77Ea, 0x4200000000000000000000000000000000000006);
        configureChain("degen", false, 666666666, 0xF058Eb3C946F0eaeCa3e6662300cb01165c64edE, 0xEb54dACB4C2ccb64F8074eceEa33b5eBb38E5387);
        configureChain("cyber", true, 7560, OP_STACK_WETH);
        configureChain("blast", true, 81457, 0x4300000000000000000000000000000000000004);
        configureChain("scroll", true, 534352, 0x5300000000000000000000000000000000000004);
        configureChain("gnosis", false, 100, 0x6A023CCd1ff6F2045C3309768eAd9E68F978f6e1, 0xe91D153E0b41518A2Ce8Dd3D7944Fa863463a97d);
    }
}
