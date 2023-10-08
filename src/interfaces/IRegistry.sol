// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {Structs} from "src/libraries/structs.sol";

interface IRegistry {
    function writeToATPNRegistry(address contractAddress, string memory name) external;

    function writeToNTRRegistry(Structs.Review memory review) external;

    function getProtocolName(address contractAddress) external view returns (bytes memory);
}
