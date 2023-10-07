// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.17;

contract Inbox {

    event RequestEmited(string name);

    function emitRequest(string memory name) internal {
        emit RequestEmited(name);
    }
}