// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {IInbox} from "src/interfaces/IInbox.sol";

abstract contract BaseReviewer {
    address inboxAddress;
    IInbox inbox;
    string name;
    /**
     */
    constructor(address _inboxAddress, string storage _name) {
        inboxAddress = _inboxAddress;
        inbox = IInbox(inboxAddress);
        name = _name;
    }
    /**
    @dev Implement this function if inheritted by contract using our protocol. 
        It should specify any additional logic when registering. 
     */
    function _register() internal virtual;

    /**
     */
    function register(address contractUser, address caller) external {
        inbox.registerContract(name);
        inbox.registerCall(name, contractUser, caller);
        _register();
    }
}
