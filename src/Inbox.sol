// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {IInbox} from "src/interfaces/IInbox.sol";

contract Inbox is IInbox {
    
    event RequestEmited(bytes name);
    event ReviewEmited(bytes review);

    error NotAContract(address _address);
    mapping (address => string) contractToAppName;

    function emitRequest(string memory name) external {
        if (isContract(msg.sender)) {
            contractToAppName[msg.sender] = name;
            emit RequestEmited(abi.encode(name));
        } else {
            revert NotAContract(msg.sender); 
        }
    }
    
    function emitReview(string memory review) external {
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
