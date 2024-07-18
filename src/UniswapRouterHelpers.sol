// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {BaseChainSetup} from "./BaseChainSetup.sol";
import {IQuoterV2} from "@uniswap/v3-periphery/contracts/interfaces/IQuoterV2.sol";

import {ChainAliases} from "./ChainAliases.sol";
import {UsdcHelper} from "./UsdcHelper.sol";

contract UniswapRouterHelpers is BaseChainSetup, ChainAliases, UsdcHelper {
    mapping(string => IQuoterV2) uniQuoterLookup;
    mapping(string => address) public uniRouterLookup;

    uint24 constant TICK_SIZE_1 = 100;
    uint24 constant TICK_SIZE_2 = 300;
    uint24 constant TICK_SIZE_3 = 500;

    address constant COMMON_SWAP_ROUTER_02 = 0x68b3465833fb72A70ecDF485E0e4C7bD8665Fc45;
    address constant COMMON_QUOTER = 0x61fFE014bA17989E743c5F6cB21bF9697530B21e;

    function getUniRouter(string memory chain) public view returns (address) {
        return uniRouterLookup[chain];
    }

    function _switchAndGetQuoter(
        string memory chain
    ) private returns (IQuoterV2 quoter) {
        switchTo(chain);
        quoter = uniQuoterLookup[chain];
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
        (/*uint amount*/, bool success) = quoteIn(
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

    function pathOutPolygon(
        address srcToken,
        address dstToken
    ) public view returns (bytes memory path, bool overrode) {
        path = "";
        overrode = false;
        if (
            srcToken == getUsdc(polygon) &&
            (dstToken == getWrapped(polygon) || dstToken == address(0))
        ) {
            path = pathOut(polygon, srcToken, dstToken, TICK_SIZE_3);
            overrode = true;
        }
    }

    function pathOut(
        string memory chain,
        address srcToken,
        address dstToken
    ) public returns (bytes memory path) {
        if (strCompare(chain, polygon)) {
            (bytes memory _path, bool overrode) = pathOutPolygon(
                srcToken,
                dstToken
            );
            if (overrode) {
                return _path;
            }
        }
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
        // Uniswap SwapRouter02
        uniRouterLookup[ethereum] = COMMON_SWAP_ROUTER_02;
        uniRouterLookup[arbitrum] = COMMON_SWAP_ROUTER_02;
        uniRouterLookup[optimism] = COMMON_SWAP_ROUTER_02;
        uniRouterLookup[polygon] = COMMON_SWAP_ROUTER_02;
        uniRouterLookup[base] = 0x2626664c2603336E57B271c5C0b26F421741e481;
        uniRouterLookup[avalanche] = 0xbb00FF08d01D300023C629E8fFfFcb65A5a578cE;
        uniRouterLookup[zora] = 0x7De04c96BE5159c3b5CeffC82aa176dc81281557;
        uniRouterLookup[degen] = 0x9c0dF4b950ca19Db6fEC13ab79aD180a9C15a41E;
        uniRouterLookup[bnb] = 0xB971eF87ede563556b2ED4b1C0b0019111Dd85d2;
        uniRouterLookup[blast] = 0x549FEB8c9bd4c12Ad2AB27022dA12492aC452B66;

        // Uniswap QuoterV2
        uniQuoterLookup[ethereum] = IQuoterV2(COMMON_QUOTER);
        uniQuoterLookup[arbitrum] = IQuoterV2(COMMON_QUOTER);
        uniQuoterLookup[optimism] = IQuoterV2(COMMON_QUOTER);
        uniQuoterLookup[polygon] = IQuoterV2(COMMON_QUOTER);
        uniQuoterLookup[base] = IQuoterV2(0x3d4e44Eb1374240CE5F1B871ab261CD16335B76a);
        uniQuoterLookup[avalanche] = IQuoterV2(0xbe0F5544EC67e9B3b2D979aaA43f18Fd87E6257F);
        uniQuoterLookup[degen] = IQuoterV2(0xe0b3133592CD29BaA7d958Bc7675C40E83071Ae1);
        uniQuoterLookup[zora] = IQuoterV2(0x11867e1b3348F3ce4FcC170BC5af3d23E07E64Df);
        uniQuoterLookup[bnb] = IQuoterV2(0x78D78E420Da98ad378D7799bE8f4AF69033EB077);
        uniQuoterLookup[blast] = IQuoterV2(0x6Cdcd65e03c1CEc3730AeeCd45bc140D57A25C77);
    }
}
