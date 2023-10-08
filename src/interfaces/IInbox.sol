// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;
import {Structs} from "src/libraries/structs.sol";

interface IInbox {
    /**
    Writes the contract address,mapped onto its name, inside the Registry
    @param contractAddress : address of the contract we register. 
     */
    function registerContract(address contractAddress) external;

    /**
    Register the caller inside the private mapping. 
    @param caller : address of the user. 
    @param contractAddress : address of the contract he called in the protocol.
     */
    function registerCall(
        address caller,
        address contractAddress
    ) external;

    /**
    Propagate the review onto IPFS if proof of membership in the group of eligible reviewers is 
    verified
    @param review : data containing the review
    @param response : proof of membership in the Sismo group. 
     */
    function propagateReview(
        Structs.Review memory review,
        bytes memory response
    ) external;
}
