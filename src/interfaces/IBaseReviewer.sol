// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {Structs} from "src/libraries/structs.sol";

interface IBaseReviewer {
    /**
     * We register the contract address in the registry, mapped onto its protocol name
     * @param contractAddress : contract address we register
     */
    function register(address contractAddress) external;

    /**
     * Publish a survey on IPFS
     * @param review : struct containing the review information
     * @param response : proof of belonging to the dedicated Sismo Group.
     */
    function propagateReview(
        Structs.Review memory review,
        bytes memory response
    ) external;
}
