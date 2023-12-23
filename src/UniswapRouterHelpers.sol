// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {BaseChainSetup} from "./BaseChainSetup.sol";
import {IQuoterV2} from "@uniswap/v3-periphery/contracts/interfaces/IQuoterV2.sol";

import {ChainAliases} from "./ChainAliases.sol";

contract UniswapRouterHelpers is BaseChainSetup, ChainAliases {
    mapping(string => IQuoterV2) quoterLookup;
    mapping(string => address) public uniswapperLookup;

    uint24 constant TICK_SIZE_1 = 100;
    uint24 constant TICK_SIZE_2 = 300;
    uint24 constant TICK_SIZE_3 = 500;

    address constant COMMON_SWAP_ROUTER_02 =
        0x68b3465833fb72A70ecDF485E0e4C7bD8665Fc45;
    address constant COMMON_QUOTER = 0x61fFE014bA17989E743c5F6cB21bF9697530B21e;
    address constant AVAX_SWAPROUTER =
        0xbb00FF08d01D300023C629E8fFfFcb65A5a578cE;
    address constant AVAX_QUOTER = 0xbe0F5544EC67e9B3b2D979aaA43f18Fd87E6257F;

    function getUniRouter(string memory chain) public view returns (address) {
        return uniswapperLookup[chain];
    }

    function _switchAndGetQuoter(
        string memory chain
    ) private returns (IQuoterV2 quoter) {
        switchTo(chain);
        quoter = quoterLookup[chain];
    }

    function pathIn(
        string memory chain,
        address srcToken,
        address dstToken,
        uint24 tickSize
    ) public view returns (bytes memory path) {
        srcToken = srcToken == address(0) ? getWrapped(chain) : srcToken;
        dstToken = dstToken == address(0) ? getWrapped(chain) : dstToken;
        if (srcToken == dstToken) {
            return bytes("");
        }
        return abi.encodePacked(srcToken, tickSize, dstToken);
    }

    function pathOut(
        string memory chain,
        address srcToken,
        address dstToken,
        uint24 tickSize
    ) public view returns (bytes memory path) {
        srcToken = srcToken == address(0) ? getWrapped(chain) : srcToken;
        dstToken = dstToken == address(0) ? getWrapped(chain) : dstToken;
        if (srcToken == dstToken) {
            return "";
        }
        return abi.encodePacked(dstToken, tickSize, srcToken);
    }

    function quoteIn(
        string memory chain,
        bytes memory path,
        uint256 amountIn
    ) public returns (uint256 amountOut, bool success) {
        if (path.length == 0) {
            return (amountIn, true);
        }
        IQuoterV2 quoter = _switchAndGetQuoter(chain);
        try quoter.quoteExactInput(path, amountIn) returns (
            uint256 amtOut,
            uint160[] memory,
            uint32[] memory,
            uint256
        ) {
            amountOut = amtOut;
            success = true;
        } catch {
            amountOut = 0;
            success = false;
        }
    }

    function quoteOut(
        string memory chain,
        bytes memory path,
        uint256 amountOut
    ) public returns (uint256 amountIn, bool success) {
        if (path.length == 0) {
            return (amountOut, true);
        }
        IQuoterV2 quoter = _switchAndGetQuoter(chain);
        try quoter.quoteExactOutput(path, amountOut) returns (
            uint256 amtIn,
            uint160[] memory,
            uint32[] memory,
            uint256
        ) {
            amountIn = amtIn;
            success = true;
        } catch {
            amountIn = 0;
            success = false;
        }
    }

    function tryTickSize(
        string memory chain,
        address srcToken,
        address dstToken,
        uint24 tickSize
    ) private returns (bool) {
        (uint amount, bool success) = quoteIn(
            chain,
            pathIn(chain, srcToken, dstToken, tickSize),
            1e9
        );
        return success;
    }

    function pathIn(
        string memory chain,
        address srcToken,
        address dstToken
    ) public returns (bytes memory path) {
        if (tryTickSize(chain, srcToken, dstToken, TICK_SIZE_1)) {
            return pathIn(chain, srcToken, dstToken, TICK_SIZE_1);
        }
        if (tryTickSize(chain, srcToken, dstToken, TICK_SIZE_2)) {
            return pathIn(chain, srcToken, dstToken, TICK_SIZE_2);
        }
        return pathIn(chain, srcToken, dstToken, TICK_SIZE_3);
    }

    function pathOut(
        string memory chain,
        address srcToken,
        address dstToken
    ) public returns (bytes memory path) {
        if (tryTickSize(chain, srcToken, dstToken, TICK_SIZE_1)) {
            return pathOut(chain, srcToken, dstToken, TICK_SIZE_1);
        }
        if (tryTickSize(chain, srcToken, dstToken, TICK_SIZE_2)) {
            return pathOut(chain, srcToken, dstToken, TICK_SIZE_2);
        }
        return pathOut(chain, srcToken, dstToken, TICK_SIZE_3);
    }

    // from here: https://docs.uniswap.org/contracts/v3/reference/deployments
    // for avax: https://gov.uniswap.org/t/deploy-uniswap-v3-on-avalanche/20587/19
    // avax github pr: https://github.com/Uniswap/docs/pull/629/files?short_path=132b68b#diff-132b68b7465e5d26429a710879ab4c7e7ade298c9e6be35279a7794054bc2126
    function loadAllUniRouterInfo() public {
        uniswapperLookup[ethereum] = COMMON_SWAP_ROUTER_02;
        uniswapperLookup[arbitrum] = COMMON_SWAP_ROUTER_02;
        uniswapperLookup[optimism] = COMMON_SWAP_ROUTER_02;
        uniswapperLookup[polygon] = COMMON_SWAP_ROUTER_02;
        uniswapperLookup[avalanche] = AVAX_SWAPROUTER;
        vm.label(COMMON_SWAP_ROUTER_02, "Uniswap Common Swap Router");
        vm.label(AVAX_SWAPROUTER, "Uniswap AVAX Swap Router");
        quoterLookup[ethereum] = IQuoterV2(COMMON_QUOTER);
        quoterLookup[arbitrum] = IQuoterV2(COMMON_QUOTER);
        quoterLookup[optimism] = IQuoterV2(COMMON_QUOTER);
        quoterLookup[polygon] = IQuoterV2(COMMON_QUOTER);
        quoterLookup[avalanche] = IQuoterV2(AVAX_QUOTER);
        vm.label(COMMON_QUOTER, "Uniswap Common Quoter");
        vm.label(AVAX_QUOTER, "Uniswap AVAX Quoter");
    }
}
