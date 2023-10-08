// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {IRegistry} from "src/interfaces/IRegistry.sol";
import {Structs} from "src/libraries/structs.sol";

contract Registry is IRegistry {
    mapping(address => bytes) contractAddressToProtocolName;
    mapping(bytes => bytes[]) nameToCIDS;

    function writeToATPNRegistry(
        address contractAddress,
        string memory name
    ) external {
        contractAddressToProtocolName[contractAddress] = abi.encode(name);
    }

    function writeToNTRRegistry(Structs.Review memory review) external {
        bytes memory encodedCID = abi.encode(review.cid);
        bytes memory encodedName = abi.encode(review.name);

        nameToCIDS[encodedName].push(encodedCID);
    }

    function getProtocolName(
        address contractAddress
    ) external view returns (bytes memory) {
        return contractAddressToProtocolName[contractAddress];
    }

    function getCIDArray(
        string memory name
    ) external view returns (string[] memory) {
        bytes memory encodedName = abi.encode(name);
        uint256 length = nameToCIDS[encodedName].length;
        string[] memory cids = new string[](length);
        for (uint256 i = 0; i < length; i += 1) {
            cids[i] = abi.decode(nameToCIDS[encodedName][i], (string));
        }
        return cids;
    }
}
