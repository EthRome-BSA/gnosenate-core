// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

interface IBaseReviewer {
    /**
     * This function registers the caller in the mapping
     * @param caller : contracct address caller
     */

    function register(address caller) external;
}
