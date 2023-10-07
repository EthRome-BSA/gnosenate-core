// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {IInbox} from "src/interfaces/IInbox.sol";

contract Inbox is IInbox {
    event RequestEmited(bytes name);
    event ReviewEmited(bytes review);

    function emitRequest(string memory name) external {
        emit RequestEmited(abi.encode(name));
    }

    function emitReview(string memory review) external {
        emit ReviewEmited(abi.encode((review)));
    }
}
