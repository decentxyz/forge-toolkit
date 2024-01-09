// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {BaseChainSetup} from "./BaseChainSetup.sol";
import {ILayerZeroEndpoint} from "LayerZero/interfaces/ILayerZeroEndpoint.sol";
import {VmSafe} from "forge-std/Vm.sol";
import {console2} from "forge-std/console2.sol";

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
        vm.label(lzEndpoint, string.concat("lz_endpoint_", chain));
        lzIdLookup[chain] = lzId;
    }

    function startRecordingLzMessages() public {
        vm.recordLogs();
    }

    function getPacket(string memory src) private returns (bytes memory) {
        VmSafe.Log[] memory entries = vm.getRecordedLogs();
        for (uint i = 0; i < entries.length; i++) {
            if (entries[i].topics[0] == keccak256("Packet(bytes)")) {
                console2.logBytes32(entries[i].topics[0]);
                console2.logBytes(entries[i].data);
                return entries[i].data;
            }
        }
        revert(string.concat("no packet was emitted at: ", src));
    }

    function extractLzInfo(
        bytes memory packet
    )
        private
        returns (
            uint64 nonce,
            uint16 localChainId,
            address sourceUa,
            uint16 dstChainId,
            address dstAddress
        )
    {
        assembly {
            let start := add(packet, 64)
            nonce := mload(add(start, 8))
            localChainId := mload(add(start, 10))
            sourceUa := mload(add(start, 30))
            dstChainId := mload(add(start, 32))
            dstAddress := mload(add(start, 52))
        }
    }

    function extractAppPayload(
        bytes memory packet
    ) private returns (bytes memory payload) {
        uint start = 64 + 52;
        uint payloadLength = packet.length - start;
        payload = new bytes(payloadLength);
        assembly {
            let payloadPtr := add(packet, start)
            let destPointer := add(payload, 32)
            for {
                let i := 32
            } lt(i, payloadLength) {
                i := add(i, 32)
            } {
                mstore(destPointer, mload(add(payloadPtr, i)))
                destPointer := add(destPointer, 32)
            }
        }
    }

    function deliverLzMessageAtDestination(
        string memory src,
        string memory dst,
        uint gasLimit
    ) public {
        bytes memory packet = getPacket(src);
        (
            uint64 nonce,
            uint16 localChainId,
            address sourceUa,
            uint16 dstChainId,
            address dstAddress
        ) = extractLzInfo(packet);
        bytes memory payload = extractAppPayload(packet);
        receiveLzMessage(src, dst, sourceUa, dstAddress, gasLimit, payload);
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

        bytes memory srcPath = abi.encodePacked(srcUa, dstUa);

        uint64 nonce = dstEndpoint.getInboundNonce(srcLzId, srcPath);

        address defaultLibAddress = dstEndpoint.defaultReceiveLibraryAddress();

        startImpersonating(defaultLibAddress);

        dstEndpoint.receivePayload(
            srcLzId, // src chain id
            srcPath, // src address
            dstUa, // dst address
            nonce + 1, // nonce
            gasLimit, // gas limit
            payload // payload
        );

        stopImpersonating();
    }
}
