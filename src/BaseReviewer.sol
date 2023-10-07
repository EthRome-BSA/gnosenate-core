// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {IInbox} from "src/interfaces/IInbox.sol";

abstract contract BaseReviewer {
    address inboxAddress;
    IInbox inbox;

    constructor(address _inboxAddress) {
        inboxAddress = _inboxAddress;
        inbox = IInbox(inboxAddress);
    }
}
