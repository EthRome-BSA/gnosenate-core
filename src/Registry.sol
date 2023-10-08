// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {IRegistry} from "src/interfaces/IRegistry.sol";
import {Structs} from "src/libraries/structs.sol";

contract Registry is IRegistry {
    mapping(address => bytes) contractAddressToProtocolName;
    mapping(bytes => bytes[]) nameToReviews;

    function writeToATPNRegistry(address contractAddress, string memory name) external {
        contractAddressToProtocolName[contractAddress] = abi.encode(name);
    }

    function writeToNTRRegistry(Structs.Review memory review) external {
        bytes memory encodedReview = abi.encode(review.score, review.review);
        bytes memory encodedName = abi.encode(review.name);
        nameToReviews[encodedName].push(encodedReview);
    }

    function getProtocolName(address contractAddress) external view returns (bytes memory) {
        return contractAddressToProtocolName[contractAddress];
    }
}
