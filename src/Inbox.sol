// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {IInbox} from "src/interfaces/IInbox.sol";

contract Inbox is IInbox {
    
    event RequestEmited(bytes nameEncoded);
    event ProtocolRegistered(bytes nameEncoded);
    event ReviewEmited(bytes reviewEncoded);

    error NotAContract(address _address);
    mapping (address => bytes) contractToAppName;
    mapping (address => mapping(address => uint256)) userToContractVisitationFreq;

    function registerContract(string calldata name) external {
        if (isContract(msg.sender)) {
            contractToAppName[msg.sender] = abi.encode(name);
            emit ProtocolRegistered(abi.encode(name));
        } else {
            revert NotAContract(msg.sender); 
        }
    }

    function emitRequest(string calldata name) external returns (address, uint256) {
        uint256 freq = userToContractVisitationFreq[tx.origin][msg.sender]++;
        emit RequestEmited(abi.encode(name));
        return (tx.origin, freq);
    }


    function emitReview(string calldata review) external {
        emit ReviewEmited(abi.encode((review)));
    }

    function isContract(address _candidateAddress) internal view returns (bool){
        uint32 size;
        assembly {
            size := extcodesize(_candidateAddress)
        }
        return size == 0;

    }
}
