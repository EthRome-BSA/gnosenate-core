// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {IInbox} from "src/interfaces/IInbox.sol";
import {Structs} from "src/libraries/structs.sol";
import {Owned} from "solmate/auth/Owned.sol";

abstract contract BaseReviewer {
    address inboxAddress;
    IInbox inbox;
    string name;

    /**
    Constructor for the BaseReviewer contract. 
    @param _inboxAddress : address of the associated inbox contract. 
    @param _name         : name the protocol chooses to set.  
     */
    constructor(address _inboxAddress, string memory _name) {
        inboxAddress = _inboxAddress;
        inbox = IInbox(inboxAddress);
        name = _name;
    }

    /**
     * Function to register to be called fromt eh contract inheritting this
     * @param caller : caller of the contract
     */
    function register(address caller) external {
        inbox.registerContract(address(this));
        inbox.registerCall(caller, address(this));
        _register();
    }

    /**
    Function that enables to propagate the review of entities that are entitled (
    i.e. members of the associated Sismo group
    )
     */

    function propagateReview(
        Structs.Review memory review,
        bytes memory response
    ) external {
        inbox.propagateReview(review, response);
    }

    /**
     * @dev Implement this function if inheritted by contract using our protocol.
     * It should specify any additional logic when registering.
     */
    function _register() internal virtual;
}
