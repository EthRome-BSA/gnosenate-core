// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {Structs} from "src/libraries/structs.sol";

interface IBaseReviewer {
    /**
     * This function registers the caller in the mapping
     * @param caller : contracct address caller
     */

    function register(address caller) external;

    function writeReview(
        Structs.Review memory review,
        bytes memory response
    ) external;
}
