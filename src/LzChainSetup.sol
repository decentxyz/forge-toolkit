// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {BaseChainSetup} from "./BaseChainSetup.sol";
import {ILayerZeroEndpoint} from "LayerZero/interfaces/ILayerZeroEndpoint.sol";

abstract contract MockEndpoint is ILayerZeroEndpoint {
    address public defaultReceiveLibraryAddress;
}

contract LzChainSetup is BaseChainSetup {
    mapping(string => MockEndpoint) lzEndpointLookup;
    mapping(string => uint16) lzIdLookup;

    function configureLzChain(
        string memory chain,
        uint16 lzId,
        address lzEndpoint
    ) internal {
        // from here: https://layerzero.gitbook.io/docs/technical-reference/mainnet/supported-chain-ids
        lzEndpointLookup[chain] = MockEndpoint(lzEndpoint);
        lzIdLookup[chain] = lzId;
    }

    function receiveLzMessage(
        string memory srcChain,
        string memory dstChain,
        address srcUa,
        address dstUa,
        uint gasLimit,
        bytes memory payload
    ) public {
        switchTo(dstChain);

        MockEndpoint dstEndpoint = lzEndpointLookup[dstChain];

        uint16 srcLzId = lzIdLookup[srcChain];

        uint64 nonce = dstEndpoint.getInboundNonce(
            srcLzId,
            abi.encode(srcUa, dstUa)
        );

        address defaultLibAddress = dstEndpoint.defaultReceiveLibraryAddress();

        startImpersonating(defaultLibAddress);

        dstEndpoint.receivePayload(
            srcLzId, // src chain id
            abi.encodePacked(srcUa, dstUa), // src address
            dstUa, // dst address
            nonce + 1, // nonce
            gasLimit, // gas limit
            payload // payload
        );

        stopImpersonating();
    }
}
