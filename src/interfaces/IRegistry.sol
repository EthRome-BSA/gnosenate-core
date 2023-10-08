// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {Structs} from "src/libraries/structs.sol";

interface IRegistry {
    /**
    Writes in the registry where contract Addresses are associated with protocol names
    @param contractAddress : address of the contract we register
    @param name : name of the protocol the contract belongs to 
     */
    function writeToATPNRegistry(
        address contractAddress,
        string memory name
    ) external;

    /**
    Writes in the registry associating reviews to protocol names. 
    @param review : struct containing the review made by the verified anonymous user. 
     */
    function writeToNTRRegistry(Structs.Review memory review) external;

    /**
    Getter for the protocol's name
    @param contractAddress : address of the contract we want to know the name of the protocol. 
     */
    function getProtocolName(
        address contractAddress
    ) external view returns (bytes memory);

    function getCIDArray(
        string memory name
    ) external view returns (string[] memory);
}
