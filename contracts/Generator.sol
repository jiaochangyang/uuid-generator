// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.27;

contract Generator {
    function generateUUID(
        bytes32 seed,
        address from
    ) public pure returns (bytes32 _uuid) {
        bytes memory internalSeed = abi.encodePacked(seed);
        bytes32 hash = keccak256(
            abi.encodePacked(internalSeed, abi.encodePacked(from))
        );
        bytes memory uuidSeed = abi.encodePacked(bytes16(hash));
        uuidSeed[6] = (uuidSeed[6] & 0x0f) | 0x40;
        uuidSeed[8] = (uuidSeed[8] & 0x3f) | 0x80;
        bytes32 uuid = bytes32(_bytes16ToHex(bytes16(uuidSeed)));
        return uuid;
    }

    function _bytes16ToHex(bytes16 data) internal pure returns (bytes32 _hex) {
        bytes memory alphabet = "0123456789abcdef";
        bytes memory hexRepresentation = new bytes(32);

        for (uint256 i = 0; i < 16; i++) {
            uint8 byteValue = uint8(data[i]);
            hexRepresentation[2 * i] = alphabet[byteValue >> 4];
            hexRepresentation[2 * i + 1] = alphabet[byteValue & 0x0f];
        }

        return bytes32(hexRepresentation);
    }
}
