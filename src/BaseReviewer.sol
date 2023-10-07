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
    Function to register to be called fromt eh contract inheritting this
    @param caller : caller of the contract
     */
    function register(address caller) external {
        inbox.registerContract(name);
        inbox.registerCall(name, caller, address(this));
        _register();
    }

    /**
    @dev Implement this function if inheritted by contract using our protocol. 
    It should specify any additional logic when registering. 
     */
    function _register() internal virtual;
}
