// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.17;

import {IInbox} from "src/interfaces/IInbox.sol";

contract Inbox is IInbox {

    event RequestEmited(string name);

    function emitRequest(string memory name) external {
        emit RequestEmited(name);
    }
}