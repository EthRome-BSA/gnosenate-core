// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {IInbox} from "src/interfaces/IInbox.sol";

contract Inbox is IInbox {
    // Events 
    event RequestEmited(bytes nameEncoded);
    event ProtocolRegistered(bytes nameEncoded);
    event ReviewEmited(bytes reviewEncoded);

    // Errors
    error NotAContract(address _address);
    error NotRegisteredForReview(address _address, string message);

    // Mappings
    mapping(address => bytes) contractToAppName;
    mapping(address => mapping(address => uint256)) userToContractVisitationFreq;

    /**
    Function to register the contract's name
    @param name : The name the cotnract wants to give its app in the registry.
     */
    function registerContract(string calldata name) external {
        if (_isContract(msg.sender)) {
            contractToAppName[msg.sender] = abi.encode(name);
            emit ProtocolRegistered(abi.encode(name));
        } else {
            revert NotAContract(msg.sender);
        }
    }

    /**
    Function to register the call by the user of some contract
    @param name : Name given to the App by the contract
    @param caller : address of the caller
    @param contractAddress : address of the contract calling the function
     */

    function registerCall(
        string calldata name,
        address caller,
        address contractAddress
    ) external returns (address, uint256) {
        uint256 freq = userToContractVisitationFreq[caller][contractAddress]++;
        emit RequestEmited(abi.encode(name));
        return (caller, freq);
    }

    /**
    Function to write and emit a review
    @param review : review to write
    @param caller : address calling the contract
    @param contractAddress : contract address calling the function
     */
    function emitReview(
        string calldata review,
        address caller,
        address contractAddress
    ) external {
        if (userToContractVisitationFreq[caller][contractAddress] == 0) {
            revert NotRegisteredForReview(
                caller,
                "Use the protocol to make review"
            );
        }

        // TODO : store the review somewhere

        emit ReviewEmited(abi.encode((review)));
    }

    /**
    Function to verify if an address is a contract
    @param _candidateAddress : address to verify
     */

    function _isContract(
        address _candidateAddress
    ) internal view returns (bool) {
        uint32 size;
        assembly {
            size := extcodesize(_candidateAddress)
        }
        return size == 0;
    }
}
